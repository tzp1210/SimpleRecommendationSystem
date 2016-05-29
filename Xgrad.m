function grad = Xgrad(i, k, lambda, Y, R, X, Theta, num_users, ...
                      num_movies, num_features)
%  Computing the gradient of X(i, k)
grad = 0;
for j = 1 : num_users
    if R(i, j) == 1
        grad = grad + (Theta(j, :) * X(i, :)' - Y(i, j)) * Theta(j, k);
    end
end
grad = grad + lambda * X(i, k);

end
