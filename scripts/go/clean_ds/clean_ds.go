package main

import (
	"fmt"
	"os"
	"path/filepath"
	"time"
)

func spinner(done chan bool) {
	spinChars := []string{"⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"}
	i := 0
	for {
		select {
		case <-done:
			fmt.Printf("\r") // Clear the spinner line
			return
		default:
			fmt.Printf("\rSearching %s", spinChars[i])
			i = (i + 1) % len(spinChars)
			time.Sleep(100 * time.Millisecond)
		}
	}
}

func main() {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error getting home directory: %v\n", err)
		os.Exit(1)
	}

	// Start spinner in a goroutine
	done := make(chan bool)
	go spinner(done)

	count := 0
	err = filepath.Walk(homeDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return nil // Skip files we can't access
		}
		if info.Name() == ".DS_Store" {
			if err := os.Remove(path); err != nil {
				fmt.Fprintf(os.Stderr, "\rError removing %s: %v\n", path, err)
			} else {
				count++
			}
		}
		return nil
	})

	// Stop the spinner
	done <- true
	close(done)

	if err != nil {
		fmt.Fprintf(os.Stderr, "\rError walking directory: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("\rRemoved %d .DS_Store files\n", count)
}
