extern crate hexe;

use std::mem;

use hexe::engine::Engine;
use hexe::prelude::*;

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
