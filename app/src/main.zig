const std = @import("std");
const server_addr = "127.0.0.1";
const server_port = 8000;

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(gpa.deinit() == .ok);
    const allocator = gpa.allocator();
    const http = std.http;
    var server = http.Server.init(allocator, .{ .reuse_address = true });
    defer server.deinit();

    const address = try std.net.Address.parse(allocator, server_addr, server_port, .{ .ipv4 = true });
    try server.listen(address);

    const request = try server.acceptRequest();
    defer request.deinit();
}

test "simple test" {}
