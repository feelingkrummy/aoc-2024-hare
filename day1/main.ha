use fmt;
use os;
use io;
use strings;

use part1;
use part2;

export fn main() void = {
	fmt::println("Advent of Code Day 1")!;

	// const file = os::open("example.txt")!;
	const file = os::open("input.txt")!;
	defer io::close(file)!;

	const source = io::drain(file)!;
	defer free(source);
	const input_str = strings::fromutf8(source)!;

	let result1 = part1::solve(input_str);
	fmt::printfln("Part 1 Result : {}", result1)!;

	let result2 = part2::solve(input_str);
	fmt::printfln("Part 2 Result : {}", result2)!;
};
