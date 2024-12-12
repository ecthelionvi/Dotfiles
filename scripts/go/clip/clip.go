package main

import (
	"fmt"
	"io"
	"os"
	"os/exec"
	"path/filepath"
)

func copyToClipboard(filePath string) error {
	// Open the file
	file, err := os.Open(filePath)
	if err != nil {
		return fmt.Errorf("failed to open file: %v", err)
	}
	defer file.Close()

	// Create pbcopy command
	cmd := exec.Command("pbcopy")
	stdin, err := cmd.StdinPipe()
	if err != nil {
		return fmt.Errorf("failed to create stdin pipe: %v", err)
	}

	// Start the command
	if err := cmd.Start(); err != nil {
		return fmt.Errorf("failed to start pbcopy: %v", err)
	}

	// Copy file content to pbcopy's stdin
	if _, err := io.Copy(stdin, file); err != nil {
		return fmt.Errorf("failed to copy to clipboard: %v", err)
	}

	// Close stdin and wait for pbcopy to finish
	stdin.Close()
	if err := cmd.Wait(); err != nil {
		return fmt.Errorf("pbcopy failed: %v", err)
	}

	fileName := filepath.Base(filePath)
	fmt.Printf("Copied %s to clipboard\n", fileName)
	return nil
}

func main() {
	if len(os.Args) != 2 {
		fmt.Println("Usage: clip <file_path>")
		os.Exit(1)
	}

	if err := copyToClipboard(os.Args[1]); err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}
}
