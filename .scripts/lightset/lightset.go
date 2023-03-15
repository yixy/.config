package main

import (
	"io/fs"
	"os"
)

func main() {
	if len(os.Args) < 2 {
		panic("Args is not enough")
	}
	err := os.WriteFile("/sys/class/backlight/acpi_video0/brightness", []byte(os.Args[1]), fs.FileMode(0644))
	if err != nil {
		panic(err)
	}
}
