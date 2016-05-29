function grad = Thetagrad(j, k, lambda, Y, R, X, Theta, num_users, ...
                      num_movies, num_features)
%  Computing the gradient of Theta(j, k)
grad = 0;
for i = 1 : num_movies
    if R(i, j) == 1
        grad = grad + (Theta(j, :) * X(i, :)' - Y(i, j)) * X(i, k);
    end
end
grad = grad + lambda * Theta(j, k);

end
