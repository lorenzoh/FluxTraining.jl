
"""
    CustomCallback(f, TEvent, [TPhase = Phase, access = (;)])

A callback that runs `f(learner)` every time `TEvent` is triggered
in `TPhase`.

If `f` needs to access learner state, pass `access`, a named tuple
in the same form as [`stateaccess`](#).
"""
mutable struct CustomCallback{E<:Event,P<:Phase} <: Callback
    f::Any
    access
end

function CustomCallback(f, E::Type{<:Event}, P::Type{<:Phase}, access = (;))
    return CustomCallback{E, P}(f, access)
end


stateaccess(cc::CustomCallback) = cc.access


function on(::E, ::P, cb::CustomCallback{E,P}, learner) where {E<:Event,P<:Phase}
    cb.f(learner)
end
