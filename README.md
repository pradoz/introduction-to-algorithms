<!-- [![CI](https://github.com/pradoz/introduction-to-algorithms/actions/workflows/zig.yml/badge.svg)](https://github.com/pradoz/introduction-to-algorithms/actions/workflows/zig.yml) -->

# Overview
Introduction to Algorithms Textbook Implementations in the Zig programming language

## Common Commands

```bash
# Build everything
zig build

# Run the main executable
zig build run

# Run with arguments
zig build run -- arg1 arg2

# Run all tests
zig build test

# Build examples
zig build examples

# Run specific example
zig build run-example1

# Generate documentation
zig build docs

# Build for release
zig build -Doptimize=ReleaseFast

# Cross-compile
zig build -Dtarget=x86_64-linux
```
