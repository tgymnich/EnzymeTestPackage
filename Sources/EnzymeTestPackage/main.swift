// This is our enzyme differentiable function. Behold the awesomeness!
public func awesome(a: Float, b: Float) -> Float {
    a * a + b * b * b
}

// We need a C callable wrapper. That wrapper must also take any parameters as pointers,
// because enzyme does not seem to support returning the derivative of non-pointer
// parameters except via the (single) return code of the generated autodiff function, and
// we have two parameters and want two distinct derivatives.
@_cdecl("awesomeWrapper") func awesomeWrapper(a: UnsafeMutablePointer<Float>?, b: UnsafeMutablePointer<Float>?) -> Float {
    awesome(a: a!.pointee, b: b!.pointee)
}

// Determine the derivatives with respect to 'a' and 'b' when calling
// awesome() with the specified values.
public func awesomeDerivative(a: Float, b: Float) -> (Float, Float) {
    // Note: must initialize derivatives to zero before calling enzyme.
    var dA: Float = 0
    var dB: Float = 0

    // We need copies of the parameters so we can pass by reference.
    var aCopy = a
    var bCopy = b

    // Do the thing!
    __enzyme_autodiff_Float_FloatFloat(awesomeWrapper,
                                       &aCopy, &dA,
                                       &bCopy, &dB)
    return (dA, dB)
}

public func awesomeValueAndDerivative(a: Float, b: Float) -> (Float, (Float, Float)) {
    let value = awesome(a: a, b: b)
    let derivatives = awesomeDerivative(a: a, b: b)
    return (value, derivatives)
}

var (value, derivatives) = awesomeValueAndDerivative(a: 3, b: 5)
print("awesome(3,5) = \(value), dA = \(derivatives.0), dB = \(derivatives.1)")

#if BENCHMARK
    var sum: Float = 0
    let iterations = 100_000_000

    for i in 1 ... iterations {
        (value, derivatives) = awesomeValueAndDerivative(a: 3 * Float(i), b: 5 * Float(i))
        sum += value + derivatives.0 + derivatives.1 // just so the compiler can't optimize out the call.
    }

    print("Ran \(iterations) iterations, sum = \(sum).")

#endif

