const std = @import("std");
const aoc_2024_zig = @import("aoc_2024_zig");
const fs = std.fs;

fn show(x: anytype) void {
    std.debug.print("{}", .{x});
}

pub fn main() !void {
    const puzzle_test = fs.Dir.openFile(fs.cwd(), "../resources/puzzle_text.txt", .{}) catch {
        return {};
    };
    defer puzzle_test.close();
    const buf: []u8 = "" ** 100;
    // Prints to stderr, ignoring potential errors.
    std.debug.print("{}", .{try puzzle_test.read(buf)});
}

test "simple test" {
    const gpa = std.testing.allocator;
    var list: std.ArrayList(i32) = .empty;
    defer list.deinit(gpa); // Try commenting this out and see if zig detects the memory leak!
    try list.append(gpa, 42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "fuzz example" {
    const Context = struct {
        fn testOne(context: @This(), input: []const u8) anyerror!void {
            _ = context;
            // Try passing `--fuzz` to `zig build test` and see if it manages to fail this test case!
            try std.testing.expect(!std.mem.eql(u8, "canyoufindme", input));
        }
    };
    try std.testing.fuzz(Context{}, Context.testOne, .{});
}
