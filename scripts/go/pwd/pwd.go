package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
)

func copyToClipboard(text string) error {
	cmd := exec.Command("pbcopy")
	pipe, err := cmd.StdinPipe()
	if err != nil {
		return fmt.Errorf("failed to create stdin pipe: %v", err)
	}

	if err := cmd.Start(); err != nil {
		return fmt.Errorf("failed to start pbcopy: %v", err)
	}

	if _, err := pipe.Write([]byte(text)); err != nil {
		return fmt.Errorf("failed to write to pipe: %v", err)
	}

	if err := pipe.Close(); err != nil {
		return fmt.Errorf("failed to close pipe: %v", err)
	}

	if err := cmd.Wait(); err != nil {
		return fmt.Errorf("pbcopy failed: %v", err)
	}

	return nil
}

func main() {
	var path string
	var err error

	switch len(os.Args) {
	case 1:
		// Get current working directory if no argument provided
		path, err = os.Getwd()
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error getting current directory: %v\n", err)
			os.Exit(1)
		}
	case 2:
		// Use provided file path
		path = os.Args[1]
		if _, err := os.Stat(path); os.IsNotExist(err) {
			fmt.Fprintf(os.Stderr, "%s not found\n", path)
			os.Exit(1)
		}
	default:
		fmt.Fprintln(os.Stderr, "Usage: pwd [file_path]")
		os.Exit(1)
	}

	// Get the real path, resolving any symlinks
	realPath, err := filepath.EvalSymlinks(path)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error resolving path: %v\n", err)
		os.Exit(1)
	}

	// Get absolute path
	absPath, err := filepath.Abs(realPath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error getting absolute path: %v\n", err)
		os.Exit(1)
	}

	// Clean the path to remove any redundant elements
	finalPath := filepath.Clean(absPath)

	if err := copyToClipboard(finalPath); err != nil {
		fmt.Fprintf(os.Stderr, "Error copying to clipboard: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("Copied %s to clipboard\n", finalPath)
}
