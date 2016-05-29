function J = CostFunction(Y, R, X, Theta, num_users, ...
                            num_movies, num_features, lambda)
%  Computing J
%  Considering we may recode this to other programming language, 
%  I don't use much vectorization.
J = 0;
for i = 1 : num_movies
    for j = 1 : num_users
        if R(i, j) == 1
            J = J + (Theta(j, :) * X(i, :)' - Y(i, j))^2;
        end
    end
end
J = J / 2;

for i = 1 : num_movies
    for k = 1 : num_features
        J = J + (lambda / 2) * X(i, k)^2;
    end
end
        
for j = 1 : num_users
    for k = 1 : num_features
        J = J + (lambda / 2) * Theta(j, k)^2;
    end
end

end

            