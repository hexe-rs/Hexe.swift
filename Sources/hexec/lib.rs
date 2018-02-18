extern crate hexe;

use std::mem;

use hexe::engine::Engine;
use hexe::prelude::*;

#[no_mangle]
pub unsafe extern "C" fn hexe_square_distance(s1: u8, s2: u8) -> usize {
    Square::distance(mem::transmute(s1), mem::transmute(s2))
}

#[no_mangle]
pub unsafe extern "C" fn hexe_square_man_distance(s1: u8, s2: u8) -> usize {
    Square::man_distance(mem::transmute(s1), mem::transmute(s2))
}

#[no_mangle]
pub unsafe extern "C" fn hexe_square_center_distance(square: u8) -> usize {
    Square::center_distance(mem::transmute(square))
}

#[no_mangle]
pub unsafe extern "C" fn hexe_square_center_man_distance(square: u8) -> usize {
    Square::center_man_distance(mem::transmute(square))
}

#[no_mangle]
pub unsafe extern "C" fn hexe_pawn_attacks(square: u8, color: u8) -> u64 {
    Square::pawn_attacks(mem::transmute(square), mem::transmute(color)).0
}

#[no_mangle]
pub unsafe extern "C" fn hexe_knight_attacks(square: u8) -> u64 {
    Square::knight_attacks(mem::transmute(square)).0
}

#[no_mangle]
pub unsafe extern "C" fn hexe_king_attacks(square: u8) -> u64 {
    Square::king_attacks(mem::transmute(square)).0
}

#[no_mangle]
pub unsafe extern "C" fn hexe_rook_attacks(square: u8, occ: u64) -> u64 {
    Square::rook_attacks(mem::transmute(square), occ.into()).0
}

#[no_mangle]
pub unsafe extern "C" fn hexe_bishop_attacks(square: u8, occ: u64) -> u64 {
    Square::bishop_attacks(mem::transmute(square), occ.into()).0
}

#[no_mangle]
pub unsafe extern "C" fn hexe_queen_attacks(square: u8, occ: u64) -> u64 {
    Square::queen_attacks(mem::transmute(square), occ.into()).0
}

#[no_mangle]
pub extern "C" fn hexe_engine_new() -> Box<Engine> {
    Default::default()
}

#[no_mangle]
pub unsafe extern "C" fn hexe_engine_destroy(e: Box<Engine>) {
    drop(e);
}
