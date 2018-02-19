// Note: using uint8_t to represent Squares is very unsafe

#include <stdint.h>
#include <stddef.h>
#include <string.h>

#define NUM_SQUARES 64

typedef uint64_t bitboard;

typedef void* _Nonnull engine_ptr;

typedef struct {
    uint8_t bytes[NUM_SQUARES];
} piece_map;

piece_map hexe_piece_map_new() {
    piece_map map = {
        .bytes = { [0 ... NUM_SQUARES - 1] = 12 }
    };
    return map;
}

size_t hexe_square_distance(uint8_t s1, uint8_t s2);
size_t hexe_square_man_distance(uint8_t s1, uint8_t s2);
size_t hexe_square_center_distance(uint8_t square);
size_t hexe_square_center_man_distance(uint8_t square);

bitboard hexe_pawn_attacks(uint8_t square, uint8_t color);
bitboard hexe_knight_attacks(uint8_t square);
bitboard hexe_king_attacks(uint8_t square);
bitboard hexe_rook_attacks(uint8_t square, bitboard occ);
bitboard hexe_bishop_attacks(uint8_t square, bitboard occ);
bitboard hexe_queen_attacks(uint8_t square, bitboard occ);

engine_ptr hexe_engine_new();
void hexe_engine_destroy(engine_ptr ptr);
