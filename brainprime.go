package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

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

	return file
}

func compInc(file *os.File) {
	file.WriteString("# +\n")
	file.WriteString("lb $t0, 0($t5)\n")
	file.WriteString("inc $t0\n")
	file.WriteString("sb $t0, 0($t5)\n")
}

func compDec(file *os.File) {
	file.WriteString("# -\n")
	file.WriteString("lb $t0, 0($t5)\n")
	file.WriteString("dec $t0\n")
	file.WriteString("sb $t0, 0($t5)\n")
}

func compNext(file *os.File) {
	file.WriteString("# >\n")
	file.WriteString("inc $t5\n")
}

func compPrev(file *os.File) {
	file.WriteString("# <\n")
	file.WriteString("dec $t5\n")
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

	label := 0
	var open []int

	file := createFile(strings.Split(args[1], ".")[0])
	defer file.Close()

	source := loadFile(args[1])
	for _, i := range source {
		switch i {
		case "+":
			compInc(file)
		case "-":
			compDec(file)
		case ">":
			compNext(file)
		case "<":
			compPrev(file)
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
	}

	file.WriteString("# loop\n")
	file.WriteString("_loop:\n")
	file.WriteString("li $sc, 100\n")
	file.WriteString("syscall\n")
	file.WriteString("j *_loop\n")

	exec.Command("./ZPrime", "as", file.Name())
}
