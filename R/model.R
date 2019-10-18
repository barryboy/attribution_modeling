sample_train_test_sets <- function(df, size, conv_ratio) {
  df_nonconv <- df[df$conversion == 0,]
  df_conv <- df[df$conversion == 1,]
  conv_size <- size * conv_ratio
  nconv_size <- size * (1-conv_ratio)
  if (conv_size > nrow(df_conv)) {stop(paste('too big sample size (max:',nrow(df_conv)*(1/conv_ratio),')'))} 
  df_train <- rbind(df_nonconv[sample(nrow(df_nonconv), nconv_size), ], df_conv[sample(nrow(df_conv), conv_size), ])
  df_test <- rbind(df_nonconv[sample(nrow(df_nonconv), nconv_size), ], df_conv[sample(nrow(df_conv), conv_size), ])
  
  return(list(test = df_test, train = df_train))
}

sample_dataset <- function(df, ps, pc) {
  ps_n <- round(nrow(df) * ps)
  pc_cols <- colnames(df)[!colnames(df) %in% c("userkey", "conversion")]
  pc_sample <- c(sample(pc_cols, round(length(pc_cols)*pc)), 'conversion')
  return(df[, pc_sample, with=FALSE][sample(.N, ps_n)])
}

run_logit_regression <- function(df) {
  model <- glm(conversion ~., family=binomial(link='logit'), data=df)
  summary(model)
}


bagged_regression <- function(df, ps, pc) {
  predictors <- colnames(df)[!colnames(df) %in% c("userkey", "conversion")]
}

sample_size <- 10000
conv_ratio <- .2
S <- 3 # liczba iteracji całej procedury
M <- 10 # liczba iteracji regresji w każdym przebiegu
PS <- c(.25, .5, .75)
PC <- c(.25, .5, .75)
results <- data.frame(S = integer(0), ps = factor(NULL, levels = ps), pc = factor(NULL, levels = pc), V = numeric(0), A = numeric(0))

for (iter_S in 1:S) {
  train_test <- sample_train_test_sets(df, size = sample_size, conv_ratio = conv_ratio)
  for (ps in PS) {
    for (pc in PC) {
      # TU ZDEFINIOWAĆ TABLICĘ COEFFICIENTÓW + ACC MODELU
      for (iter_M in 1:M) {
        df_sample <- sample_dataset(test_train$train, ps, pc)  
      }
    }
  }
}


# test_train <- sample_train_test_sets(df, 10000, 0.2)
# 
# df_sample <- sample_dataset(test_train$train, .25, .25)
# 
# run_logit_regression(df_sample)
