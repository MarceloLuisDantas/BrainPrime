package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

type command struct {
	cmd   string
	total uint
	next  *command
	prev  *command
}

func NewCommand(cmd string, prev *command) *command {
	c := new(command)
	c.cmd = cmd
	c.next = nil
	c.prev = prev
	c.total = 1
	return c
}

type program struct {
	head *command
	tail *command
}

func NewProgram() *program {
	p := new(program)
	p.head = NewCommand("start", nil)
	p.tail = p.head
	return p
}

func (prg *program) addCommand(cmd string) {
	c := NewCommand(cmd, prg.tail)
	prg.tail.next = c
	prg.tail = c
}

func (prg *program) optimize() {
	cmd := prg.head
	for cmd.cmd != "end" {
		c := cmd.cmd
		if (c == "+" || c == "-" || c == ">" || c == "<") && cmd.next.cmd == c {
			cmd.total += 1
			sup := cmd.next
			sup.prev = nil
			sup.next.prev = cmd
			cmd.next = sup.next
			sup.next = nil
		} else {
			cmd = cmd.next
		}
	}
}

func loadFile(file string) []string {
	data, err := os.ReadFile(file)
	if err != nil {
		panic(err)
	}
	return strings.Split(string(data), "")
}

func createFile(name string) *os.File {
	file, err := os.Create(fmt.Sprint(name + ".asm"))
	if err != nil {
		panic(err)
	}
	return file
}

func compStart(file *os.File) {
	file.WriteString(".text\n")
	file.WriteString("j *_main\n")
	file.WriteString("_print_char:\n")
	file.WriteString("lb $t0, 0($t5)\n")
	file.WriteString("sll $t0, $t0, 8\n")
	file.WriteString("ori $t0, $t0, 16\n")
	file.WriteString("svr $t0, 0($t4)\n")
	file.WriteString("inc $t4\n")
	file.WriteString("return\n")
	file.WriteString("_main:\n")
	file.WriteString("li $t5, 16\n")
}

func compEnd(file *os.File) {
	file.WriteString("# loop\n")
	file.WriteString("_loop:\n")
	file.WriteString("li $sc, 100\n")
	file.WriteString("syscall\n")
	file.WriteString("j *_loop\n")
}

func compInc(file *os.File, total uint) {
	file.WriteString("# +\n")
	file.WriteString("lb $t0, 0($t5)\n")
	file.WriteString(fmt.Sprint("addi $t0, $t0, ", total, "\n"))
	file.WriteString("sb $t0, 0($t5)\n")
}

func compDec(file *os.File, total uint) {
	file.WriteString("# -\n")
	file.WriteString("lb $t0, 0($t5)\n")
	file.WriteString(fmt.Sprint("subi $t0, $t0, ", total, "\n"))
	file.WriteString("sb $t0, 0($t5)\n")
}

func compNext(file *os.File, total uint) {
	file.WriteString("# >\n")
	file.WriteString(fmt.Sprint("addi $t5, $t5, ", total, "\n"))
}

func compPrev(file *os.File, total uint) {
	file.WriteString("# <\n")
	file.WriteString(fmt.Sprint("subi $t5, $t5, ", total, "\n"))
}

func compPrint(file *os.File) {
	file.WriteString("# .\n")
	file.WriteString("jal *_print_char\n")
}

func compOpen(file *os.File, label int) {
	file.WriteString("# [\n")
	file.WriteString(fmt.Sprint("_", label, ":\n"))
	file.WriteString("lb $t0, 0($t5)\n")
	file.WriteString(fmt.Sprint("beq $t0, $zero, *_", label, "r\n"))
}

func compClose(file *os.File, label int) {
	file.WriteString("# ]\n")
	file.WriteString("lb $t0, 0($t5)\n")
	file.WriteString(fmt.Sprint("bne $t0, $zero, *_", label, "\n"))
	file.WriteString(fmt.Sprint("_", label, "r:\n"))
}

func main() {
	// t4 sera o pivo na vram para printar char
	// t5 sera o pivo na memoria

	args := os.Args
	if len(args) != 2 {
		fmt.Println("Uso errado")
		return
	}

	file := createFile(strings.Split(args[1], ".")[0])
	defer file.Close()

	program := NewProgram()
	source := loadFile(args[1])
	for _, i := range source {
		switch i {
		case "+":
			program.addCommand("+")
		case "-":
			program.addCommand("-")
		case ">":
			program.addCommand(">")
		case "<":
			program.addCommand("<")
		case ".":
			program.addCommand(".")
		case "[":
			program.addCommand("[")
		case "]":
			program.addCommand("]")
		}
	}

	program.addCommand("end")
	program.optimize()

	label := 0
	var open []int
	cmd := program.head
	for cmd != nil {
		i := cmd.cmd
		switch i {
		case "start":
			compStart(file)
		case "end":
			compEnd(file)
		case "+":
			compInc(file, cmd.total)
		case "-":
			compDec(file, cmd.total)
		case ">":
			compNext(file, cmd.total)
		case "<":
			compPrev(file, cmd.total)
		case ".":
			compPrint(file)
		case "[":
			label += 1
			open = append(open, label)
			compOpen(file, label)
		case "]":
			to_close := open[len(open)-1]
			open = open[:len(open)-1]
			compClose(file, to_close)
		}
		cmd = cmd.next
	}

	// file.WriteString("# loop\n")
	// file.WriteString("_loop:\n")
	// file.WriteString("li $sc, 100\n")
	// file.WriteString("syscall\n")
	// file.WriteString("j *_loop\n")

	exec.Command("./ZPrime", "as", file.Name())
}
