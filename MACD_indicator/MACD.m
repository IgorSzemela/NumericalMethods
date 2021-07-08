function exp_mov_avg = EMA(data_vector, N, i)
average = 2/(N+1);
moving = (1 - average).^[0:N];
exp = sum(data_vector(i:-1:i-N).*moving);
denominator = sum(moving);
exp_mov_avg = exp/denominator;
end