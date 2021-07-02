// C prototypes of the functions enzyme will auto-generate for us.
//
// The function name must begin with __enzyme_autodiff; anything after that is just used to make
// the name unique based on the function prototype, since C doesn't have polymorphic functions.
//
// My crude convention: first token is the return type, second token is the list of parameters
// concatenated. So __enzyme_autodiff_Double_FloatDouble would descrive the derivative function
// for a function with the prototype float f(float, double)

float __enzyme_autodiff_Float_FloatFloat(
                float(*)(float*, float*), // function to differentiate: it
                                          // accepts two floats as input and
                                          // returns a float.
                const float*,             // The first input parameter.
                float*,                   // (output): the derivative of the
                                          // first parameter.
                const float*,             // The second input parameter.
                float*);                  // (output): the derivative of the
                                          // second parameter.


