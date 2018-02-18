extern crate hexe;

use hexe::engine::Engine;

#[no_mangle]
pub extern "C" fn hexe_engine_new() -> *mut Engine {
    Box::into_raw(Box::new(Engine::default()))
}

#[no_mangle]
pub unsafe extern "C" fn hexe_engine_destroy(e: *mut Engine) {
    drop(Box::from_raw(e));
}
