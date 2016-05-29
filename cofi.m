%  Collaborative Filtering Algorithm for predicting movie ratings
%  Programmed by TZP 2014/12/8
%  As the website for downloading the data set has broken down,
%  I use Andrew NG's data set to train the model.

%  load data
%  This file contains the ratings(Y and R) given by users
load ('ex8_movies.mat');  
%  This file contains the randomly initialized data X and Theta,
%  it also contains num_users, num_movies and num_features.
load ('ex8_movieParams.mat');

%  You can change the size of the data set below
num_movies = 10;       %<=1682
num_users = 5;         %<=943
num_features = 5;   %<=10

Y = Y(1: num_movies, 1: num_users);
R = R(1: num_movies, 1: num_users);
X = X(1: num_movies, 1: num_features);
Theta = Theta(1: num_users, 1: num_features);
figure(1);
imagesc(Y);
hold on;
title('Original ratings');
xlabel('movies');
ylabel('users');
hold off;

%  Collaborative Filtering Algorithm
%  Considering we may recode this to other programming language, 
%  I don't use much vectorization.
tmp_X = zeros(size(X));
tmp_Theta = zeros(size(Theta)); %  To update simultaneously

alpha = 0.0001;  %  Learning rate
lambda = 0;  %  Regularization Parameters


threshhold = 10000;
record_CostFunc = zeros(threshhold);

t = 1;
while t <= threshhold
    for i = 1 : num_movies
        for k = 1 : num_features
            tmp_X(i, k) = X(i, k) - alpha * Xgrad(i, k, lambda, ...
                                        Y, R, X, Theta, num_users, ...
                                        num_movies, num_features);
        end
    end
    for j = 1 : num_users
        for k = 1 : num_features
            tmp_Theta(j, k) = Theta(j, k) - alpha * Thetagrad(j, k, lambda, ...
                                        Y, R, X, Theta, num_users, ...
                                        num_movies, num_features);
        end
    end
    X = tmp_X;
    Theta = tmp_Theta;
    
    record_CostFunc(t) = CostFunction(Y, R, X, Theta, num_users, ...
                            num_movies, num_features, lambda);
    t = t + 1;
end

%  Plot the diagram of the variance of J to debug
figure(2);
plot(record_CostFunc(1 : threshhold), 'LineWidth', 1);
hold on;
title('Plot the diagram of the variance of J to debug');
xlabel('Iteration');
ylabel('J');
hold off;

%  Computing predictions
predict_ratings = X * Theta';
figure(3);
imagesc(predict_ratings);
hold on;
title('Predicted ratings');
xlabel('movies');
ylabel('users');
hold off;