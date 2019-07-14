#ADM_USER_LOGIN
required_data("STG_BETTER_DIM")
ADM_USER_LOGIN <- STG_BETTER_DIM[, .(user = USERNAME, password = PW, permission = "standard", name = USERNAME)]

