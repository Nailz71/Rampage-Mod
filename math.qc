	// RAMPAGE Mod file. Last Updated 19 Sep 22

float(float minimum,float maximum) randomRange = 
{
    return random() * (maximum - minimum) + minimum;
}

float(float val1,float val2) math_max =
{
    return val1 > val2 ? val1 : val2;
}

float(float val1,float val2) math_min =
{
    return val1 < val2 ? val1 : val2;
}