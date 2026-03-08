const std = @import("std");

// Wrote this to test looping through a string
// pub fn stringToUpper(input: []const u8, output: []u8) void{
//     for(input, 0..) |c, i| {
//         output[i] = std.ascii.toUpper(c);
//     }
// }

pub fn caeserShift(shift: u8, input: []const u8, output: []u8) void{
    const alphabet = std.ascii.uppercase;

    for(input, 0..) |c, i| {
        if (std.mem.indexOfScalar(u8, alphabet, std.ascii.toUpper(c))) |idx| {
            const shiftedChar = alphabet[(idx+shift) % 26];
            output[i] = shiftedChar;
        } else {
            output[i] = c;
        }
    }
}

pub fn caeserShiftWithAllocator(allocator: std.mem.Allocator, shift: u8, input: []const u8) ![]u8 {
    const output = try allocator.alloc(u8, input.len);
    
    const alphabet = std.ascii.uppercase;

    for(input, 0..) |c, i| {
        if (std.mem.indexOfScalar(u8, alphabet, std.ascii.toUpper(c))) |idx| {
            const shiftedChar = alphabet[(idx+shift) % 26];
            output[i] = shiftedChar;
        } else {
            output[i] = c;
        }
    }
    return output;
}

pub fn main() !void{
    const myString = "hello\n";
    const shift: u8 = 3;
    
    // Out parameter caeserShift
    const len = myString.len;
    var result: [len]u8 = undefined;
    caeserShift(shift, myString, &result);
    std.debug.print("{s}", .{result});
   
    // Allocator caeserShift
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const allocatedResult = try caeserShiftWithAllocator(allocator, shift, myString);
    defer allocator.free(allocatedResult);
    std.debug.print("Allocated Result: {s}", .{allocatedResult});
}
