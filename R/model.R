sample_train_test_sets <- function(df, size, conv_ratio) {
  df_nonconv <- df[df$conversion == 0,]
  df_conv <- df[df$conversion == 1,]
  conv_size <- size * conv_ratio
  nconv_size <- size * (1-conv_ratio)
  df_train <- rbind(df_nonconv[sample(nrow(df_nonconv), nconv_size), ], df_conv[sample(nrow(df_conv), conv_size), ])
  df_test <- rbind(df_nonconv[sample(nrow(df_nonconv), nconv_size), ], df_conv[sample(nrow(df_conv), conv_size), ])
  
  return(list(test = df_test, train = df_train))
}

sample_dataset <- function(df, ps, pc) {
  ps_n <- round(nrow(df) * ps)
  print(ps_n)
  pc_cols <- colnames(df)[!colnames(df) %in% c("userkey", "conversion")]
  pc_sample <- sample(pc_cols, round(length(pc_cols)*pc))
  return(df[, pc_sample, with=FALSE][sample(.N, ps_n)])
}

run_bagged_regression <- function(df, predictors, target) {
  
}

#test_train <- sample_train_test_sets(df, 10000, 0.2)

df_sample <- sample_dataset(test_train$train, .25, .25)
