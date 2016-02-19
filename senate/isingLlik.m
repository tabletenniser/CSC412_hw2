function [ll,grad] = isingLlik(theta, ss, L, N)
% [ll,grad] = isingLlik(theta, ss, L, N)
% Compute the log-likelihood and gradient for fully-connected Ising model
% 
% Inputs:
%    theta: Current estimate of the parameters of the Ising model. The
%           first N entries, theta(1:N) are the parameters governing the
%           unary potentials, and the rest govern the pairwise potentials
%           of the Ising model.
%    ss: Sufficient statistics needed to compute log-likelihood and
%        gradients. These are returned by suffStats.m
%    L: Number of training examples
%    N: Number of unary-terms in theta (number of Senators, in Question 2)
%
% Outputs:
%    ll: the log-likelihood of the model
%    grad: the gradient of the log-likelihood function for the given value
%          of theta

