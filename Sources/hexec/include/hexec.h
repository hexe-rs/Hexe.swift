// Note: using uint8_t to represent Squares is very unsafe

#include <stdint.h>

typedef uint64_t Bitboard;

typedef void* _Nonnull EnginePtr;

Bitboard hexe_pawn_attacks(uint8_t square, uint8_t color);
Bitboard hexe_knight_attacks(uint8_t square);
Bitboard hexe_king_attacks(uint8_t square);
Bitboard hexe_rook_attacks(uint8_t square, Bitboard occ);
Bitboard hexe_bishop_attacks(uint8_t square, Bitboard occ);
Bitboard hexe_queen_attacks(uint8_t square, Bitboard occ);

EnginePtr hexe_engine_new();
void hexe_engine_destroy(EnginePtr ptr);
