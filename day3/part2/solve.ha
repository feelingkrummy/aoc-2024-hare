use regex;
use fmt;
use strings;
use strconv;

export fn solve(input: str) i64 = {
	// Note : When I had the pattern as `don't\(\)|do\(\)|mul\([0-9]+,[0-9]+\)`
	// It would not detect the mul expressions
	// However, when I reordered it as below, suddenly it worked. 
	// The abovre expression works with grep so I don't think it's a
	// malformed pattern
	// I think there is a potential bug. This warrents further investigation
	// at another time
	const pattern: str = `don't\(\)|do\(\)|mul\([0-9]+,[0-9]+\)`;
	const re = match (regex::compile(pattern)) {
	case let re: regex::regex =>
		yield re;
	case regex::error =>
		fmt::fatalf("Error: could not compile patter \"{}\"");
	};
	defer regex::finish(&re);

	const results = regex::findall(&re, input);
	defer regex::result_freeall(results);

	let enabled = true;
	let sum: i64 = 0;

	for (let result .. results) {
		for: inner ( let capture .. result ) {
			let mult_str = strings::dup(capture.content);
			if (mult_str == "don't()") {
				enabled = false;
				continue: inner;
			};
			if (mult_str == "do()") {
				enabled = true;
				continue: inner;
			};

			mult_str = strings::trimprefix(mult_str, "mul(");
			mult_str = strings::trimsuffix(mult_str, ")");

			let nums = strings::split(mult_str, ",");
			defer free(nums);

			let pair: (i64, i64) = (0, 0);
			pair.0 = strconv::stoi64(nums[0]) as i64;
			pair.1 = strconv::stoi64(nums[1]) as i64;

			if ( enabled ) {
				sum += pair.0 * pair.1;
			};
		};
	};

	return sum;
};
