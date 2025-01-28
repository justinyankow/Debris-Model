#include "mex.hpp"
#include "mexAdapter.hpp"

using matlab::mex::ArgumentList;
using namespace matlab::data;

class MexFunction : public matlab::mex::Function {
    
    std::shared_ptr<matlab::engine::MATLABEngine> matlabPtr = getEngine();

public:
    void operator()(ArgumentList outputs, ArgumentList inputs) 
    {
        checkArguments(outputs, inputs);
        Array object(inputs[0]);
        double dt = inputs[1][0];
        double mu = inputs[2][0];
        Update(object, dt, mu);
        outputs[0] = object;
    }

    void Update(Array& obj, double dt, double mu) 
    {
        TypedArray<double> position = matlabPtr->getProperty(obj, u"position");
        TypedArray<double> velocity = matlabPtr->getProperty(obj, u"velocity");
        matlabPtr->setProperty(obj, u"prev_position", position);

        double radius = sqrt(position[0]*position[0] + position[1]*position[1] + position[2]*position[2]);
        TypedArray<double> accel = position;
        for (int i=0;i<3;i++) accel[i] *= -mu / (radius*radius*radius);


        for (int i=0;i<3;i++) velocity[i] += dt * accel[i];
        matlabPtr->setProperty(obj, u"velocity", velocity);

        for (int i=0;i<3;i++) position[i] += dt * velocity[i];
        matlabPtr->setProperty(obj, u"position", position);
    }

    void checkArguments(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
        matlab::data::ArrayFactory factory;

        /*
        if (inputs.size() != 3) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("Three inputs required") }));
        }

        if (inputs[1].getNumberOfElements() != 1) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("Input multiplier must be a scalar") }));
        }
        
        if (inputs[0].getType() != matlab::data::ArrayType::DOUBLE ||
            inputs[0].getType() == matlab::data::ArrayType::COMPLEX_DOUBLE) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("Input multiplier must be a noncomplex scalar double") }));
        }

        if (inputs[1].getType() != matlab::data::ArrayType::DOUBLE ||
            inputs[1].getType() == matlab::data::ArrayType::COMPLEX_DOUBLE) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("Input matrix must be type double") }));
        }
     

        if (inputs[1].getDimensions().size() != 2) {
            matlabPtr->feval(u"error", 
                0, std::vector<matlab::data::Array>({ factory.createScalar("Input must be m-by-n dimension") }));
        }
       */
    }
};