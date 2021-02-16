#include <iostream>
#include <vector>




class BlasiusProfile
{
private:
    double Ux;
    double xPosition;
    double nu;

    double reynoldsX;

public: 
    // Constructor
    BlasiusProfile(double Ux_, double xPosition_, double nu_)
    {
        Ux = Ux_;
        xPosition = xPosition_;
        nu = nu_;

        reynoldsX = Ux*xPosition/nu;
    }

};



int main ()
{

    double Ux = 0.7432;
    double xPosition = 0.19;
    double nu = 1.5e-05;
    double reynoldsX = Ux*xPosition/nu;

    std::cout << "Re_x: " << reynoldsX << std::endl;

    BlasiusProfile(Ux, xPosition, nu);

    // -------
    std::vector<double> state;
    state.

    // ---- Advance RK ---- \\

        double k1, k2, k3, k4;
        k1 = f(tn, yn)
        k2 


    return (0);
}
