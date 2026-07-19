const std = @import("std");
const mem = std.mem;

pub const TranslationError = error{
    InvalidCodon,
};

pub const Protein = enum {
    methionine,
    phenylalanine,
    leucine,
    serine,
    tyrosine,
    cysteine,
    tryptophan,
    stop,
};

pub fn proteins(allocator: mem.Allocator, strand: []const u8) (mem.Allocator.Error || TranslationError)![]Protein {
    var result: std.ArrayList(Protein) = .empty;
    defer result.deinit(allocator);

    var start: usize = 0;
    const codon_len = 3;
    var end = start + codon_len;
    while (end <= strand.len) {
        end = @min(strand.len, start + codon_len);
        const codon_window = strand[start..end];
        if (codon_window.len == 0) break;

        if (codon_window.len != 3) return TranslationError.InvalidCodon;
        const codon = codon_window[0..3];

        const protein = try translateCodon(codon);
        if (protein == Protein.stop) break;

        try result.append(allocator, protein);
        start = end;
    }

    return result.toOwnedSlice(allocator);
}

fn translateCodon(codon: *const [3]u8) TranslationError!Protein {
    const codon_int = intFromCodonRuntime(codon);
    return switch (codon_int) {
        intFromCodon("AUG") => Protein.methionine,
        intFromCodon("UUU"), intFromCodon("UUC") => Protein.phenylalanine,
        intFromCodon("UUA"), intFromCodon("UUG") => Protein.leucine,
        intFromCodon("UCU"), intFromCodon("UCC"), intFromCodon("UCA"), intFromCodon("UCG") => Protein.serine,
        intFromCodon("UAU"), intFromCodon("UAC") => Protein.tyrosine,
        intFromCodon("UGU"), intFromCodon("UGC") => Protein.cysteine,
        intFromCodon("UGG") => Protein.tryptophan,
        intFromCodon("UAA"), intFromCodon("UAG"), intFromCodon("UGA") => Protein.stop,
        else => TranslationError.InvalidCodon,
    };
}

fn intFromCodonRuntime(codon: *const [3]u8) u24 {
    return (@as(u24, codon[0]) << 16) | (@as(u24, codon[1]) << 8) | codon[2];
}

fn intFromCodon(comptime codon: *const [3]u8) u24 {
    return (@as(u24, codon[0]) << 16) | (@as(u24, codon[1]) << 8) | codon[2];
}
