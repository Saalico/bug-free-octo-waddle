const std = @import("std");
const aoc_2024_zig = @import("aoc_2024_zig");
const dsize = std.heap.pageSize();

var ally = std.heap.ArenaAllocator.init(std.heap.page_allocator);

pub fn grabFileContents(a: std.mem.Allocator, path: []const u8, size: ?usize) ![]u8 {
    const cwd = std.fs.cwd();
    return try cwd.readFileAlloc(a, path, size orelse std.heap.pageSize());
}

pub fn getFile_rel(path: []const u8) !std.fs.File {
    const file = try std.fs.cwd().openFile(path, .{});
    return file;
}

pub fn main() !void {
    // std.debug.print("{s}", .{try grabFileContents(ally.allocator(), "resources/puzzleText.txt", null)});
    defer ally.deinit();
    const file = try getFile_rel("resources/puzzleText.txt");
    var buffer: [dsize]u8 = undefined;
    var reader = std.fs.File.reader(file, &buffer);
    const content: []u8 = try reader.interface.readAlloc(ally.allocator(), 1024);
    std.debug.print("{s}", .{content});
    try aoc_2024_zig.bufferedPrint();
}
