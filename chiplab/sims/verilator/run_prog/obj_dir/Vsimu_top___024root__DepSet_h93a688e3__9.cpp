// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsimu_top.h for the primary calling header

#include "verilated.h"
#include "verilated_dpi.h"

#include "Vsimu_top___024root.h"

void Vsimu_top___024root___sequent__TOP__14(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___sequent__TOP__15(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___sequent__TOP__16(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___sequent__TOP__17(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___sequent__TOP__18(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___sequent__TOP__19(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___sequent__TOP__20(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___sequent__TOP__21(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___sequent__TOP__22(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___combo__TOP__23(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___combo__TOP__24(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___combo__TOP__25(Vsimu_top___024root* vlSelf);
void Vsimu_top___024root___combo__TOP__26(Vsimu_top___024root* vlSelf);

void Vsimu_top___024root___eval(Vsimu_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsimu_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsimu_top___024root___eval\n"); );
    // Body
    if (((IData)(vlSelf->aclk) & (~ (IData)(vlSelf->__Vclklast__TOP__aclk)))) {
        vlSelf->__Vm_traceActivity[1U] = 1U;
        Vsimu_top___024root___sequent__TOP__14(vlSelf);
        Vsimu_top___024root___sequent__TOP__15(vlSelf);
        Vsimu_top___024root___sequent__TOP__16(vlSelf);
        Vsimu_top___024root___sequent__TOP__17(vlSelf);
        Vsimu_top___024root___sequent__TOP__18(vlSelf);
        Vsimu_top___024root___sequent__TOP__19(vlSelf);
        Vsimu_top___024root___sequent__TOP__20(vlSelf);
        Vsimu_top___024root___sequent__TOP__21(vlSelf);
        Vsimu_top___024root___sequent__TOP__22(vlSelf);
    }
    Vsimu_top___024root___combo__TOP__23(vlSelf);
    vlSelf->__Vm_traceActivity[2U] = 1U;
    Vsimu_top___024root___combo__TOP__24(vlSelf);
    Vsimu_top___024root___combo__TOP__25(vlSelf);
    Vsimu_top___024root___combo__TOP__26(vlSelf);
    // Final
    vlSelf->__Vclklast__TOP__aclk = vlSelf->aclk;
}

QData Vsimu_top___024root___change_request_1(Vsimu_top___024root* vlSelf);

VL_INLINE_OPT QData Vsimu_top___024root___change_request(Vsimu_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsimu_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsimu_top___024root___change_request\n"); );
    // Body
    return (Vsimu_top___024root___change_request_1(vlSelf));
}

VL_INLINE_OPT QData Vsimu_top___024root___change_request_1(Vsimu_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsimu_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsimu_top___024root___change_request_1\n"); );
    // Init
    IData/*31:0*/ __Vilp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    __req |= ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
               [0U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
               [0U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [1U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [1U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [2U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [2U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [3U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [3U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [4U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [4U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [5U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [5U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [6U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [6U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [7U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [7U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [8U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [8U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [9U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [9U])
        || (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xaU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xaU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xbU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xbU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xcU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xcU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xdU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xdU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xeU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xeU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xfU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0xfU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x10U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x10U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x11U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x11U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x12U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x12U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x13U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x13U])
        || (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x14U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x14U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x15U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x15U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x16U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x16U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x17U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x17U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x18U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x18U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x19U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x19U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1aU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1aU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1bU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1bU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1cU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1cU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1dU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1dU])
        || (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1eU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1eU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1fU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x1fU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x20U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x20U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x21U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x21U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x22U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x22U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x23U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x23U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x24U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x24U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x25U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x25U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x26U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x26U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x27U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x27U])
        || (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x28U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x28U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x29U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x29U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2aU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2aU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2bU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2bU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2cU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2cU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2dU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2dU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2eU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2eU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2fU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x2fU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x30U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x30U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x31U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x31U])
        || (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x32U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x32U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x33U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x33U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x34U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x34U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x35U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x35U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x36U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x36U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x37U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x37U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x38U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x38U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x39U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x39U])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3aU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3aU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3bU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3bU])
        || (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3cU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3cU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3dU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3dU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3eU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3eU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3fU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x3fU])
         | (vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x40U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [0x40U]));
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [1U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [1U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [2U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [2U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [3U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [3U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [4U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [4U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [5U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [5U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [6U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [6U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [7U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [7U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [8U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [8U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [9U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [9U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xaU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xaU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xbU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xbU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xcU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xcU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xdU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xdU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xeU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xeU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xfU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0xfU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x10U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x10U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x11U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x11U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x12U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x12U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x13U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x13U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x14U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x14U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x15U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x15U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x16U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x16U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x17U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x17U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x18U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x18U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x19U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x19U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1aU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1aU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1bU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1bU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1cU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1cU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1dU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1dU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1eU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1eU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1fU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x1fU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x20U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x20U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x21U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x21U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x22U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x22U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x23U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x23U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x24U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x24U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x25U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x25U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x26U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x26U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x27U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x27U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x28U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x28U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x29U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x29U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2aU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2aU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2bU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2bU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2cU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2cU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2dU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2dU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2eU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2eU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2fU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x2fU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x30U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x30U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x31U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x31U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x32U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x32U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x33U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x33U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x34U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x34U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x35U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x35U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x36U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x36U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x37U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x37U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x38U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x38U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x39U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x39U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3aU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3aU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3bU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3bU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3cU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3cU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3dU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3dU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3eU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3eU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3fU] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x3fU]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    VL_DEBUG_IF( if(__req && ((vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x40U] ^ vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
                               [0x40U]))) VL_DBG_MSGF("        CHANGE: /home/mulin/chiplab/IP/myCPU/mul.v:166\n"); );
    // Final
    __Vilp = 0U;
    while ((__Vilp <= 0x40U)) {
        vlSelf->__Vchglast__TOP__simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter[__Vilp] 
            = vlSelf->simu_top__DOT__soc__DOT__cpu__DOT__u_mul__DOT__WallaceInter
            [__Vilp];
        __Vilp = ((IData)(1U) + __Vilp);
    }
    return __req;
}

#ifdef VL_DEBUG
void Vsimu_top___024root___eval_debug_assertions(Vsimu_top___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vsimu_top__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsimu_top___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->aclk & 0xfeU))) {
        Verilated::overWidthError("aclk");}
    if (VL_UNLIKELY((vlSelf->aresetn & 0xfeU))) {
        Verilated::overWidthError("aresetn");}
    if (VL_UNLIKELY((vlSelf->enable_delay & 0xfeU))) {
        Verilated::overWidthError("enable_delay");}
    if (VL_UNLIKELY((vlSelf->random_seed & 0xff800000U))) {
        Verilated::overWidthError("random_seed");}
    if (VL_UNLIKELY((vlSelf->uart_rx & 0xfeU))) {
        Verilated::overWidthError("uart_rx");}
    if (VL_UNLIKELY((vlSelf->uart_tx & 0xfeU))) {
        Verilated::overWidthError("uart_tx");}
    if (VL_UNLIKELY((vlSelf->btn_key_row & 0xf0U))) {
        Verilated::overWidthError("btn_key_row");}
    if (VL_UNLIKELY((vlSelf->btn_step & 0xfcU))) {
        Verilated::overWidthError("btn_step");}
}
#endif  // VL_DEBUG
