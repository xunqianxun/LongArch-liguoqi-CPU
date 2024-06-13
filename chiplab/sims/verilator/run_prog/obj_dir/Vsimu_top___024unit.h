// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vsimu_top.h for the primary calling header

#ifndef VERILATED_VSIMU_TOP___024UNIT_H_
#define VERILATED_VSIMU_TOP___024UNIT_H_  // guard

#include "verilated.h"
#include "verilated_save.h"

class Vsimu_top__Syms;
VL_MODULE(Vsimu_top___024unit) {
  public:

    // INTERNAL VARIABLES
    Vsimu_top__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
    Vsimu_top___024unit(const char* name);
    ~Vsimu_top___024unit();
    VL_UNCOPYABLE(Vsimu_top___024unit);

    // INTERNAL METHODS
    void __Vconfigure(Vsimu_top__Syms* symsp, bool first);
    void __Vserialize(VerilatedSerialize& os);
    void __Vdeserialize(VerilatedDeserialize& os);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
