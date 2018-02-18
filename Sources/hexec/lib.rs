extern crate hexe;

use hexe::engine::Engine;

#[no_mangle]
pub extern "C" fn hexe_engine_new() -> Box<Engine> {
    Default::default()
}

#[no_mangle]
pub unsafe extern "C" fn hexe_engine_destroy(e: Box<Engine>) {
    drop(e);
}
