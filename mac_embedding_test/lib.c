#include <julia.h>
JULIA_DEFINE_FAST_TLS()

int load_julia(void) {
    jl_init_with_image(JULIA_BINDIR, NULL);
    jl_eval_string("println(sqrt(2.0))");
    jl_atexit_hook(0);
    return 0;
}
