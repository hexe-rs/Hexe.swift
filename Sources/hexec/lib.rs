extern crate hexe;

use std::mem;
use std::os::raw;

use hexe::core::piece::map::PieceMap;
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

type StringFn = extern "C" fn(*mut raw::c_char, *mut u8);

#[no_mangle]
pub unsafe extern "C" fn hexe_piece_map_fen(ctx: *mut u8, map: &mut PieceMap, f: StringFn) {
    const NUM: usize = 8;
    const MAX: usize = NUM * NUM + 7;

    let mut buf = [0u8; MAX + 1];
    map.map_fen(|s| {
        let len = s.len();
        let buf = buf.get_unchecked_mut(..len);
        buf.copy_from_slice(s.as_bytes());
    });
    f(&mut buf as *mut _ as *mut _, ctx);
}
