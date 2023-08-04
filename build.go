package main

import (
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"
	"path/filepath"
)

// Main Work Logic
func copyFiles(sourceDir, destinationDir string) error {
	err := filepath.Walk(sourceDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		relativePath, err := filepath.Rel(sourceDir, path)
		if err != nil {
			return err
		}
		destinationPath := filepath.Join(destinationDir, relativePath)

		if info.IsDir() {
			return os.MkdirAll(destinationPath, info.Mode())
		}
		return copyFile(path, destinationPath)
	})
	return err
}

func copyFile(sourcePath, destinationPath string) error {
	source, err := os.Open(sourcePath)
	if err != nil {
		return err
	}
	defer source.Close()

	destination, err := os.Create(destinationPath)
	if err != nil {
		return err
	}
	defer destination.Close()

	_, err = io.Copy(destination, source)
	if err != nil {
		return err
	}
	return nil
}

func removeFilesWithExtension(directory, extension string) error {
	return filepath.Walk(directory, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		if !info.IsDir() && filepath.Ext(path) == extension {
			return os.Remove(path)
		}
		return nil
	})
}

func main() {
	fmt.Println("Starting XTENDED Compiler")

	// Read version and build from files (similar to your batch script)
	version, err := readFromFile("version.md")
	if err != nil {
		log.Fatal(err)
	}

	build, err := readFromFile("build.md")
	if err != nil {
		log.Fatal(err)
	}

	sum := getSum(build)

	fmt.Printf("Version: %s\n", version)
	fmt.Printf("Build: %s\n", build)
	fmt.Printf("Sum: %d\n", sum)

	// Show the menu
	showMenu()
}

func readFromFile(filename string) (string, error) {
	data, err := os.ReadFile(filename)
	if err != nil {
		return "", err
	}
	return string(data), nil
}

func getSum(build string) int {
	// For demonstration purposes, let's assume a simple sum calculation
	// You would need to implement the actual logic here
	return len(build)
}

func cleanCache(path string) error {
	cmd := exec.Command("cmd", "/c", "rd", "/s", "/q", path)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

func showMenu() {
	for {
		fmt.Println("Choose an option:")
		fmt.Println("1 - Compile For PC - DX11")
		fmt.Println("2 - Compile For MOBILE - ASTC")
		fmt.Println("3 - Compile For MOBILE - Lesta - ASTC")
		fmt.Println("4 - Compile For MOBILE-EMBED - ASTC")
		fmt.Println("v - View Git Logs")
		fmt.Println("e - Exit")

		var option string
		_, err := fmt.Scanln(&option)
		if err != nil {
			log.Fatal(err)
		}

		switch option {
		case "1":
			compileForPCDX11()
		case "2":
			compileForMobileASTC()
		case "3":
			compileForMobileLestaASTC()
		case "4":
			compileForMobileEmbedASTC()
		case "v":
			viewGitLogs()
		case "e":
			fmt.Println("Exiting...")
			return
		default:
			fmt.Println("Invalid option")
		}
	}
}

func compileForPCDX11() {
	fmt.Println("Compiling for PC - DX11")

	// Store the current working directory
	originalDir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}

	// Define paths
	srcDir := "src"
	packPCDataDir := filepath.Join("pack", "pc", "data")

	// Remove existing files and folders from pack/pc
	err = cleanCache(packPCDataDir)
	if err != nil {
		log.Fatal(err)
	}

	// Copy files and folders from src/ to pack/pc/data/
	err = copyFiles(srcDir, packPCDataDir)
	if err != nil {
		log.Fatal(err)
	}

	// Remove files with .pvr extension from pack/pc/data/
	err = removeFilesWithExtension(packPCDataDir, ".pvr")
	if err != nil {
		log.Fatal(err)
	}

	// Change working directory to pack/pc/data
	if err := os.Chdir(packPCDataDir); err != nil {
		log.Fatal(err)
	}

	// Execute dvplgo.exe with parameters cp
	dvplgoPath := filepath.Join("..", "..", "..", "bin", "dvplgo.exe")
	cmd := exec.Command(dvplgoPath, "cp")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err = cmd.Run()
	if err != nil {
		log.Fatal(err)
	}

	// Change back to the original working directory
	if err := os.Chdir(originalDir); err != nil {
		log.Fatal(err)
	}

	fmt.Println("Successfully finished PC DX11 compiling")
}

func compileForMobileASTC() {
	fmt.Println("Compiling for MOBILE - ASTC")

	// Store the current working directory
	originalDir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}

	// Define paths
	srcDir := "src"
	packPCDataDir := filepath.Join("pack", "mobile", "data")

	// Remove existing files and folders from pack/mobile
	err = cleanCache(packPCDataDir)
	if err != nil {
		log.Fatal(err)
	}

	// Copy files and folders from src/ to pack/mobile/data/
	err = copyFiles(srcDir, packPCDataDir)
	if err != nil {
		log.Fatal(err)
	}

	// Remove files with .dds extension from pack/mobile/data/
	err = removeFilesWithExtension(packPCDataDir, ".dds")
	if err != nil {
		log.Fatal(err)
	}

	// Change working directory to pack/mobile/data
	if err := os.Chdir(packPCDataDir); err != nil {
		log.Fatal(err)
	}

	// Execute dvplgo.exe with parameters cp
	dvplgoPath := filepath.Join("..", "..", "..", "bin", "dvplgo.exe")
	cmd := exec.Command(dvplgoPath, "cp")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err = cmd.Run()
	if err != nil {
		log.Fatal(err)
	}

	// Change back to the original working directory
	if err := os.Chdir(originalDir); err != nil {
		log.Fatal(err)
	}

	fmt.Println("Successfully finished MOBILE - ASTC compiling")
}

func compileForMobileLestaASTC() {
	fmt.Println("Compiling for MOBILE - Lesta - ASTC")

	// Store the current working directory
	originalDir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}

	// Define paths
	srcDir := "src"
	packPCDataDir := filepath.Join("pack", "mobile-lesta", "data")

	// Remove existing files and folders from pack/mobile-lesta
	err = cleanCache(packPCDataDir)
	if err != nil {
		log.Fatal(err)
	}

	// Copy files and folders from src/ to pack/mobile-lesta/data/
	err = copyFiles(srcDir, packPCDataDir)
	if err != nil {
		log.Fatal(err)
	}

	// Remove files with .dds extension from pack/mobile-lesta/data/
	err = removeFilesWithExtension(packPCDataDir, ".dds")
	if err != nil {
		log.Fatal(err)
	}

	// Change working directory to pack/mobile/data
	if err := os.Chdir(packPCDataDir); err != nil {
		log.Fatal(err)
	}

	// Execute dvplgo.exe with parameters cp
	dvplgoPath := filepath.Join("..", "..", "..", "bin", "dvplgo.exe")
	cmd := exec.Command(dvplgoPath, "cp")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err = cmd.Run()
	if err != nil {
		log.Fatal(err)
	}

	// Change back to the original working directory
	if err := os.Chdir(originalDir); err != nil {
		log.Fatal(err)
	}

	fmt.Println("Successfully finished MOBILE - Lesta - ASTC compiling")
}

func compileForMobileEmbedASTC() {
	fmt.Println("Compiling for MOBILE-EMBED - ASTC")

	// Store the current working directory
	originalDir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}

	// Define paths
	srcDir := "src"
	packPCDataDir := filepath.Join("pack", "mobile-embed", "data")

	// Remove existing files and folders from pack/mobile-embed
	err = cleanCache(packPCDataDir)
	if err != nil {
		log.Fatal(err)
	}

	// Copy files and folders from src/ to pack/mobile-embed/data/
	err = copyFiles(srcDir, packPCDataDir)
	if err != nil {
		log.Fatal(err)
	}

	// Remove files with .dds extension from pack/mobile-embed/data/
	err = removeFilesWithExtension(packPCDataDir, ".dds")
	if err != nil {
		log.Fatal(err)
	}

	// Change working directory to pack/mobile-embed/data
	if err := os.Chdir(packPCDataDir); err != nil {
		log.Fatal(err)
	}

	// Execute dvplgo.exe with parameters cp
	dvplgoPath := filepath.Join("..", "..", "..", "bin", "dvplgo.exe")
	cmd := exec.Command(dvplgoPath, "cp")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err = cmd.Run()
	if err != nil {
		log.Fatal(err)
	}

	// Execute dvplgo.exe with parameters cp
	dvplgoextraPath := filepath.Join("..", "..", "..", "bin", "dvplgo.exe")
	cmd = exec.Command(dvplgoextraPath, "dcp")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err = cmd.Run()
	if err != nil {
		log.Fatal(err)
	}

	// Change back to the original working directory
	if err := os.Chdir(originalDir); err != nil {
		log.Fatal(err)
	}

	fmt.Println("Successfully finished MOBILE-EMBED - ASTC compiling")
}

func viewGitLogs() {
	fmt.Println("Viewing Git Logs")

	cmd := exec.Command("git", "log")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
}
