const std = @import("std");

fn fib(n: u32) u32{
    if (n <= 1) return n;
    return(fib(n-1) + fib(n-2));
}

fn fib_dp(n: u32) u64{
    if (n <= 1) return n;
    var a: u64 = 0;
    var b: u64 = 1;
    for (2 .. n+1) |_| {
        const temp = b;
        b = a + b;
        a = temp;
    }
    return b;
}

pub fn main() !void{
    var timer = try std.time.Timer.start();
    const x = fib(42);
    const t1 = timer.read() / 1000000;
    std.debug.print("Final value: {}, time taken: {}ms\n", .{x, t1});

    timer.reset();
    
    // this will be 0ms until an even stupid number
    const y = fib_dp(80);
    const t2 = timer.read() / 1000000;
    std.debug.print("Final value (DP): {}, time taken: {}ms\n", .{y, t2});
}
