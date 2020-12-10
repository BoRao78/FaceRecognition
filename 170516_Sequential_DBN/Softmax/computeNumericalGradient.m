function numgrad = computeNumericalGradient(J, theta)
% numgrad = computeNumericalGradient(J, theta)
% theta: a vector of parameters
% J: a function that outputs a real-number. Calling y = J(theta) will return the
% function value at theta. 
  
% Initialize numgrad with zeros
numgrad = zeros(size(theta));

%% ---------- YOUR CODE HERE --------------------------------------
% Instructions: 
% Implement numerical gradient checking, and return the result in numgrad.  
% (See Section 2.3 of the lecture notes.)
% You should write code so that numgrad(i) is (the numerical approximation to) the 
% partial derivative of J with respect to the i-th input argument, evaluated at theta.  
% I.e., numgrad(i) should be the (approximately) the partial derivative of J with 
% respect to theta(i).
%                
% Hint: You will probably want to compute the elements of numgrad one at a time. 

epsilon=0.0001;
[r_theta, c_theta]=size(theta);
for i=1:r_theta
    e_i=zeros(r_theta,1);
    e_i(i,1)=1;
    theta_i_plus=theta+epsilon*e_i;
    theta_i_minus=theta-epsilon*e_i;
    numgrad(i)=(J(theta_i_plus)- J(theta_i_minus))/(2*epsilon);
end






%% ---------------------------------------------------------------
end
