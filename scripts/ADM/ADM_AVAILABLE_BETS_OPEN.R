#ADM_AVAILABLE_BETS_OPEN
required_data("STG_AVAILABLE_BETS")
ADM_AVAILABLE_BETS_OPEN <- STG_AVAILABLE_BETS[CLOSING > now(), .(PELI_ID,
                                                                 T1_NAME,
                                                                 T2_NAME,
                                                                 CLOSING)]
