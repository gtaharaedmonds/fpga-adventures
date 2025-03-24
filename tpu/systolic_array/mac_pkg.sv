package mac_pkg;
  typedef enum logic [1:0] {
    MAC_CTRL_CLR = 2'b00,
    MAC_CTRL_RUN = 2'b01,
    MAC_CTRL_LOAD_WEIGHT = 2'b10
  } mac_ctrl_t;
endpackage
