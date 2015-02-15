-----------------------------------------------------------
--  Binding for OpenGL
-----------------------------------------------------------
local ffi = require 'ffi'
local jit = require 'jit'

local const = {}

-- Boolean values
const.FALSE                                = 0x0
const.TRUE                                 = 0x1

-- Data types
const.BYTE                                 = 0x1400
const.UNSIGNED_BYTE                        = 0x1401
const.SHORT                                = 0x1402
const.UNSIGNED_SHORT                       = 0x1403
const.INT                                  = 0x1404
const.UNSIGNED_INT                         = 0x1405
const.FLOAT                                = 0x1406
const.DOUBLE                               = 0x140A
const['2_BYTES']                           = 0x1407
const['3_BYTES']                           = 0x1408
const['4_BYTES']                           = 0x1409

-- Primitives
const.POINTS                               = 0x0000
const.LINES                                = 0x0001
const.LINE_LOOP                            = 0x0002
const.LINE_STRIP                           = 0x0003
const.TRIANGLES                            = 0x0004
const.TRIANGLE_STRIP                       = 0x0005
const.TRIANGLE_FAN                         = 0x0006
const.QUADS                                = 0x0007
const.QUAD_STRIP                           = 0x0008
const.POLYGON                              = 0x0009

-- Vertex Arrays
const.VERTEX_ARRAY                         = 0x8074
const.NORMAL_ARRAY                         = 0x8075
const.COLOR_ARRAY                          = 0x8076
const.INDEX_ARRAY                          = 0x8077
const.TEXTURE_COORD_ARRAY                  = 0x8078
const.EDGE_FLAG_ARRAY                      = 0x8079
const.VERTEX_ARRAY_SIZE                    = 0x807A
const.VERTEX_ARRAY_TYPE                    = 0x807B
const.VERTEX_ARRAY_STRIDE                  = 0x807C
const.NORMAL_ARRAY_TYPE                    = 0x807E
const.NORMAL_ARRAY_STRIDE                  = 0x807F
const.COLOR_ARRAY_SIZE                     = 0x8081
const.COLOR_ARRAY_TYPE                     = 0x8082
const.COLOR_ARRAY_STRIDE                   = 0x8083
const.INDEX_ARRAY_TYPE                     = 0x8085
const.INDEX_ARRAY_STRIDE                   = 0x8086
const.TEXTURE_COORD_ARRAY_SIZE             = 0x8088
const.TEXTURE_COORD_ARRAY_TYPE             = 0x8089
const.TEXTURE_COORD_ARRAY_STRIDE           = 0x808A
const.EDGE_FLAG_ARRAY_STRIDE               = 0x808C
const.VERTEX_ARRAY_POINTER                 = 0x808E
const.NORMAL_ARRAY_POINTER                 = 0x808F
const.COLOR_ARRAY_POINTER                  = 0x8090
const.INDEX_ARRAY_POINTER                  = 0x8091
const.TEXTURE_COORD_ARRAY_POINTER          = 0x8092
const.EDGE_FLAG_ARRAY_POINTER              = 0x8093
const.V2F                                  = 0x2A20
const.V3F                                  = 0x2A21
const.C4UB_V2F                             = 0x2A22
const.C4UB_V3F                             = 0x2A23
const.C3F_V3F                              = 0x2A24
const.N3F_V3F                              = 0x2A25
const.C4F_N3F_V3F                          = 0x2A26
const.T2F_V3F                              = 0x2A27
const.T4F_V4F                              = 0x2A28
const.T2F_C4UB_V3F                         = 0x2A29
const.T2F_C3F_V3F                          = 0x2A2A
const.T2F_N3F_V3F                          = 0x2A2B
const.T2F_C4F_N3F_V3F                      = 0x2A2C
const.T4F_C4F_N3F_V4F                      = 0x2A2D

-- Matrix Mode
const.MATRIX_MODE                          = 0x0BA0
const.MODELVIEW                            = 0x1700
const.PROJECTION                           = 0x1701
const.TEXTURE                              = 0x1702

-- Points
const.POINT_SMOOTH                         = 0x0B10
const.POINT_SIZE                           = 0x0B11
const.POINT_SIZE_GRANULARITY               = 0x0B13
const.POINT_SIZE_RANGE                     = 0x0B12

-- Lines
const.LINE_SMOOTH                          = 0x0B20
const.LINE_STIPPLE                         = 0x0B24
const.LINE_STIPPLE_PATTERN                 = 0x0B25
const.LINE_STIPPLE_REPEAT                  = 0x0B26
const.LINE_WIDTH                           = 0x0B21
const.LINE_WIDTH_GRANULARITY               = 0x0B23
const.LINE_WIDTH_RANGE                     = 0x0B22

-- Polygons
const.POINT                                = 0x1B00
const.LINE                                 = 0x1B01
const.FILL                                 = 0x1B02
const.CW                                   = 0x0900
const.CCW                                  = 0x0901
const.FRONT                                = 0x0404
const.BACK                                 = 0x0405
const.POLYGON_MODE                         = 0x0B40
const.POLYGON_SMOOTH                       = 0x0B41
const.POLYGON_STIPPLE                      = 0x0B42
const.EDGE_FLAG                            = 0x0B43
const.CULL_FACE                            = 0x0B44
const.CULL_FACE_MODE                       = 0x0B45
const.FRONT_FACE                           = 0x0B46
const.POLYGON_OFFSET_FACTOR                = 0x8038
const.POLYGON_OFFSET_UNITS                 = 0x2A00
const.POLYGON_OFFSET_POINT                 = 0x2A01
const.POLYGON_OFFSET_LINE                  = 0x2A02
const.POLYGON_OFFSET_FILL                  = 0x8037

-- Display Lists
const.COMPILE                              = 0x1300
const.COMPILE_AND_EXECUTE                  = 0x1301
const.LIST_BASE                            = 0x0B32
const.LIST_INDEX                           = 0x0B33
const.LIST_MODE                            = 0x0B30

-- Depth buffer
const.NEVER                                = 0x0200
const.LESS                                 = 0x0201
const.EQUAL                                = 0x0202
const.LEQUAL                               = 0x0203
const.GREATER                              = 0x0204
const.NOTEQUAL                             = 0x0205
const.GEQUAL                               = 0x0206
const.ALWAYS                               = 0x0207
const.DEPTH_TEST                           = 0x0B71
const.DEPTH_BITS                           = 0x0D56
const.DEPTH_CLEAR_VALUE                    = 0x0B73
const.DEPTH_FUNC                           = 0x0B74
const.DEPTH_RANGE                          = 0x0B70
const.DEPTH_WRITEMASK                      = 0x0B72
const.DEPTH_COMPONENT                      = 0x1902

-- Lighting
const.LIGHTING                             = 0x0B50
const.LIGHT0                               = 0x4000
const.LIGHT1                               = 0x4001
const.LIGHT2                               = 0x4002
const.LIGHT3                               = 0x4003
const.LIGHT4                               = 0x4004
const.LIGHT5                               = 0x4005
const.LIGHT6                               = 0x4006
const.LIGHT7                               = 0x4007
const.SPOT_EXPONENT                        = 0x1205
const.SPOT_CUTOFF                          = 0x1206
const.CONSTANT_ATTENUATION                 = 0x1207
const.LINEAR_ATTENUATION                   = 0x1208
const.QUADRATIC_ATTENUATION                = 0x1209
const.AMBIENT                              = 0x1200
const.DIFFUSE                              = 0x1201
const.SPECULAR                             = 0x1202
const.SHININESS                            = 0x1601
const.EMISSION                             = 0x1600
const.POSITION                             = 0x1203
const.SPOT_DIRECTION                       = 0x1204
const.AMBIENT_AND_DIFFUSE                  = 0x1602
const.COLOR_INDEXES                        = 0x1603
const.LIGHT_MODEL_TWO_SIDE                 = 0x0B52
const.LIGHT_MODEL_LOCAL_VIEWER             = 0x0B51
const.LIGHT_MODEL_AMBIENT                  = 0x0B53
const.FRONT_AND_BACK                       = 0x0408
const.SHADE_MODEL                          = 0x0B54
const.FLAT                                 = 0x1D00
const.SMOOTH                               = 0x1D01
const.COLOR_MATERIAL                       = 0x0B57
const.COLOR_MATERIAL_FACE                  = 0x0B55
const.COLOR_MATERIAL_PARAMETER             = 0x0B56
const.NORMALIZE                            = 0x0BA1

-- User clipping planes
const.CLIP_PLANE0                          = 0x3000
const.CLIP_PLANE1                          = 0x3001
const.CLIP_PLANE2                          = 0x3002
const.CLIP_PLANE3                          = 0x3003
const.CLIP_PLANE4                          = 0x3004
const.CLIP_PLANE5                          = 0x3005

-- Accumulation buffer
const.ACCUM_RED_BITS                       = 0x0D58
const.ACCUM_GREEN_BITS                     = 0x0D59
const.ACCUM_BLUE_BITS                      = 0x0D5A
const.ACCUM_ALPHA_BITS                     = 0x0D5B
const.ACCUM_CLEAR_VALUE                    = 0x0B80
const.ACCUM                                = 0x0100
const.ADD                                  = 0x0104
const.LOAD                                 = 0x0101
const.MULT                                 = 0x0103
const.RETURN                               = 0x0102

-- Alpha testing
const.ALPHA_TEST                           = 0x0BC0
const.ALPHA_TEST_REF                       = 0x0BC2
const.ALPHA_TEST_FUNC                      = 0x0BC1

-- Blending
const.BLEND                                = 0x0BE2
const.BLEND_SRC                            = 0x0BE1
const.BLEND_DST                            = 0x0BE0
const.ZERO                                 = 0x0
const.ONE                                  = 0x1
const.SRC_COLOR                            = 0x0300
const.ONE_MINUS_SRC_COLOR                  = 0x0301
const.SRC_ALPHA                            = 0x0302
const.ONE_MINUS_SRC_ALPHA                  = 0x0303
const.DST_ALPHA                            = 0x0304
const.ONE_MINUS_DST_ALPHA                  = 0x0305
const.DST_COLOR                            = 0x0306
const.ONE_MINUS_DST_COLOR                  = 0x0307
const.SRC_ALPHA_SATURATE                   = 0x0308
const.CONSTANT_COLOR                       = 0x8001
const.ONE_MINUS_CONSTANT_COLOR             = 0x8002
const.CONSTANT_ALPHA                       = 0x8003
const.ONE_MINUS_CONSTANT_ALPHA             = 0x8004

-- Render Mode
const.FEEDBACK                             = 0x1C01
const.RENDER                               = 0x1C00
const.SELECT                               = 0x1C02

-- Feedback
const['2D']                                = 0x0600
const['3D']                                = 0x0601
const['3D_COLOR']                          = 0x0602
const['3D_COLOR_TEXTURE']                  = 0x0603
const['4D_COLOR_TEXTURE']                  = 0x0604
const.POINT_TOKEN                          = 0x0701
const.LINE_TOKEN                           = 0x0702
const.LINE_RESET_TOKEN                     = 0x0707
const.POLYGON_TOKEN                        = 0x0703
const.BITMAP_TOKEN                         = 0x0704
const.DRAW_PIXEL_TOKEN                     = 0x0705
const.COPY_PIXEL_TOKEN                     = 0x0706
const.PASS_THROUGH_TOKEN                   = 0x0700
const.FEEDBACK_BUFFER_POINTER              = 0x0DF0
const.FEEDBACK_BUFFER_SIZE                 = 0x0DF1
const.FEEDBACK_BUFFER_TYPE                 = 0x0DF2

-- Selection
const.SELECTION_BUFFER_POINTER             = 0x0DF3
const.SELECTION_BUFFER_SIZE                = 0x0DF4

-- Fog
const.FOG                                  = 0x0B60
const.FOG_MODE                             = 0x0B65
const.FOG_DENSITY                          = 0x0B62
const.FOG_COLOR                            = 0x0B66
const.FOG_INDEX                            = 0x0B61
const.FOG_START                            = 0x0B63
const.FOG_END                              = 0x0B64
const.LINEAR                               = 0x2601
const.EXP                                  = 0x0800
const.EXP2                                 = 0x0801

-- Logic Ops
const.LOGIC_OP                             = 0x0BF1
const.INDEX_LOGIC_OP                       = 0x0BF1
const.COLOR_LOGIC_OP                       = 0x0BF2
const.LOGIC_OP_MODE                        = 0x0BF0
const.CLEAR                                = 0x1500
const.SET                                  = 0x150F
const.COPY                                 = 0x1503
const.COPY_INVERTED                        = 0x150C
const.NOOP                                 = 0x1505
const.INVERT                               = 0x150A
const.AND                                  = 0x1501
const.NAND                                 = 0x150E
const.OR                                   = 0x1507
const.NOR                                  = 0x1508
const.XOR                                  = 0x1506
const.EQUIV                                = 0x1509
const.AND_REVERSE                          = 0x1502
const.AND_INVERTED                         = 0x1504
const.OR_REVERSE                           = 0x150B
const.OR_INVERTED                          = 0x150D

-- Stencil
const.STENCIL_TEST                         = 0x0B90
const.STENCIL_WRITEMASK                    = 0x0B98
const.STENCIL_BITS                         = 0x0D57
const.STENCIL_FUNC                         = 0x0B92
const.STENCIL_VALUE_MASK                   = 0x0B93
const.STENCIL_REF                          = 0x0B97
const.STENCIL_FAIL                         = 0x0B94
const.STENCIL_PASS_DEPTH_PASS              = 0x0B96
const.STENCIL_PASS_DEPTH_FAIL              = 0x0B95
const.STENCIL_CLEAR_VALUE                  = 0x0B91
const.STENCIL_INDEX                        = 0x1901
const.KEEP                                 = 0x1E00
const.REPLACE                              = 0x1E01
const.INCR                                 = 0x1E02
const.DECR                                 = 0x1E03

-- Buffers, Pixel Drawing/Reading
const.NONE                                 = 0x0
const.LEFT                                 = 0x0406
const.RIGHT                                = 0x0407
-- const.FRONT                                = 0x0404
-- const.BACK                                 = 0x0405
-- const.FRONT_AND_BACK                       = 0x0408
const.FRONT_LEFT                           = 0x0400
const.FRONT_RIGHT                          = 0x0401
const.BACK_LEFT                            = 0x0402
const.BACK_RIGHT                           = 0x0403
const.AUX0                                 = 0x0409
const.AUX1                                 = 0x040A
const.AUX2                                 = 0x040B
const.AUX3                                 = 0x040C
const.COLOR_INDEX                          = 0x1900
const.RED                                  = 0x1903
const.GREEN                                = 0x1904
const.BLUE                                 = 0x1905
const.ALPHA                                = 0x1906
const.LUMINANCE                            = 0x1909
const.LUMINANCE_ALPHA                      = 0x190A
const.ALPHA_BITS                           = 0x0D55
const.RED_BITS                             = 0x0D52
const.GREEN_BITS                           = 0x0D53
const.BLUE_BITS                            = 0x0D54
const.INDEX_BITS                           = 0x0D51
const.SUBPIXEL_BITS                        = 0x0D50
const.AUX_BUFFERS                          = 0x0C00
const.READ_BUFFER                          = 0x0C02
const.DRAW_BUFFER                          = 0x0C01
const.DOUBLEBUFFER                         = 0x0C32
const.STEREO                               = 0x0C33
const.BITMAP                               = 0x1A00
const.COLOR                                = 0x1800
const.DEPTH                                = 0x1801
const.STENCIL                              = 0x1802
const.DITHER                               = 0x0BD0
const.RGB                                  = 0x1907
const.RGBA                                 = 0x1908

-- Implementation limits
const.MAX_LIST_NESTING                     = 0x0B31
const.MAX_ATTRIB_STACK_DEPTH               = 0x0D35
const.MAX_MODELVIEW_STACK_DEPTH            = 0x0D36
const.MAX_NAME_STACK_DEPTH                 = 0x0D37
const.MAX_PROJECTION_STACK_DEPTH           = 0x0D38
const.MAX_TEXTURE_STACK_DEPTH              = 0x0D39
const.MAX_EVAL_ORDER                       = 0x0D30
const.MAX_LIGHTS                           = 0x0D31
const.MAX_CLIP_PLANES                      = 0x0D32
const.MAX_TEXTURE_SIZE                     = 0x0D33
const.MAX_PIXEL_MAP_TABLE                  = 0x0D34
const.MAX_VIEWPORT_DIMS                    = 0x0D3A
const.MAX_CLIENT_ATTRIB_STACK_DEPTH        = 0x0D3B

-- Gets
const.ATTRIB_STACK_DEPTH                   = 0x0BB0
const.CLIENT_ATTRIB_STACK_DEPTH            = 0x0BB1
const.COLOR_CLEAR_VALUE                    = 0x0C22
const.COLOR_WRITEMASK                      = 0x0C23
const.CURRENT_INDEX                        = 0x0B01
const.CURRENT_COLOR                        = 0x0B00
const.CURRENT_NORMAL                       = 0x0B02
const.CURRENT_RASTER_COLOR                 = 0x0B04
const.CURRENT_RASTER_DISTANCE              = 0x0B09
const.CURRENT_RASTER_INDEX                 = 0x0B05
const.CURRENT_RASTER_POSITION              = 0x0B07
const.CURRENT_RASTER_TEXTURE_COORDS        = 0x0B06
const.CURRENT_RASTER_POSITION_VALID        = 0x0B08
const.CURRENT_TEXTURE_COORDS               = 0x0B03
const.INDEX_CLEAR_VALUE                    = 0x0C20
const.INDEX_MODE                           = 0x0C30
const.INDEX_WRITEMASK                      = 0x0C21
const.MODELVIEW_MATRIX                     = 0x0BA6
const.MODELVIEW_STACK_DEPTH                = 0x0BA3
const.NAME_STACK_DEPTH                     = 0x0D70
const.PROJECTION_MATRIX                    = 0x0BA7
const.PROJECTION_STACK_DEPTH               = 0x0BA4
const.RENDER_MODE                          = 0x0C40
const.RGBA_MODE                            = 0x0C31
const.TEXTURE_MATRIX                       = 0x0BA8
const.TEXTURE_STACK_DEPTH                  = 0x0BA5
const.VIEWPORT                             = 0x0BA2

-- Evaluators
const.AUTO_NORMAL                          = 0x0D80
const.MAP1_COLOR_4                         = 0x0D90
const.MAP1_GRID_DOMAIN                     = 0x0DD0
const.MAP1_GRID_SEGMENTS                   = 0x0DD1
const.MAP1_INDEX                           = 0x0D91
const.MAP1_NORMAL                          = 0x0D92
const.MAP1_TEXTURE_COORD_1                 = 0x0D93
const.MAP1_TEXTURE_COORD_2                 = 0x0D94
const.MAP1_TEXTURE_COORD_3                 = 0x0D95
const.MAP1_TEXTURE_COORD_4                 = 0x0D96
const.MAP1_VERTEX_3                        = 0x0D97
const.MAP1_VERTEX_4                        = 0x0D98
const.MAP2_COLOR_4                         = 0x0DB0
const.MAP2_GRID_DOMAIN                     = 0x0DD2
const.MAP2_GRID_SEGMENTS                   = 0x0DD3
const.MAP2_INDEX                           = 0x0DB1
const.MAP2_NORMAL                          = 0x0DB2
const.MAP2_TEXTURE_COORD_1                 = 0x0DB3
const.MAP2_TEXTURE_COORD_2                 = 0x0DB4
const.MAP2_TEXTURE_COORD_3                 = 0x0DB5
const.MAP2_TEXTURE_COORD_4                 = 0x0DB6
const.MAP2_VERTEX_3                        = 0x0DB7
const.MAP2_VERTEX_4                        = 0x0DB8
const.COEFF                                = 0x0A00
const.DOMAIN                               = 0x0A02
const.ORDER                                = 0x0A01

-- Hints
const.FOG_HINT                             = 0x0C54
const.LINE_SMOOTH_HINT                     = 0x0C52
const.PERSPECTIVE_CORRECTION_HINT          = 0x0C50
const.POINT_SMOOTH_HINT                    = 0x0C51
const.POLYGON_SMOOTH_HINT                  = 0x0C53
const.DONT_CARE                            = 0x1100
const.FASTEST                              = 0x1101
const.NICEST                               = 0x1102

-- Scissor box
const.SCISSOR_TEST                         = 0x0C11
const.SCISSOR_BOX                          = 0x0C10

-- Pixel Mode / Transfer
const.MAP_COLOR                            = 0x0D10
const.MAP_STENCIL                          = 0x0D11
const.INDEX_SHIFT                          = 0x0D12
const.INDEX_OFFSET                         = 0x0D13
const.RED_SCALE                            = 0x0D14
const.RED_BIAS                             = 0x0D15
const.GREEN_SCALE                          = 0x0D18
const.GREEN_BIAS                           = 0x0D19
const.BLUE_SCALE                           = 0x0D1A
const.BLUE_BIAS                            = 0x0D1B
const.ALPHA_SCALE                          = 0x0D1C
const.ALPHA_BIAS                           = 0x0D1D
const.DEPTH_SCALE                          = 0x0D1E
const.DEPTH_BIAS                           = 0x0D1F
const.PIXEL_MAP_S_TO_S_SIZE                = 0x0CB1
const.PIXEL_MAP_I_TO_I_SIZE                = 0x0CB0
const.PIXEL_MAP_I_TO_R_SIZE                = 0x0CB2
const.PIXEL_MAP_I_TO_G_SIZE                = 0x0CB3
const.PIXEL_MAP_I_TO_B_SIZE                = 0x0CB4
const.PIXEL_MAP_I_TO_A_SIZE                = 0x0CB5
const.PIXEL_MAP_R_TO_R_SIZE                = 0x0CB6
const.PIXEL_MAP_G_TO_G_SIZE                = 0x0CB7
const.PIXEL_MAP_B_TO_B_SIZE                = 0x0CB8
const.PIXEL_MAP_A_TO_A_SIZE                = 0x0CB9
const.PIXEL_MAP_S_TO_S                     = 0x0C71
const.PIXEL_MAP_I_TO_I                     = 0x0C70
const.PIXEL_MAP_I_TO_R                     = 0x0C72
const.PIXEL_MAP_I_TO_G                     = 0x0C73
const.PIXEL_MAP_I_TO_B                     = 0x0C74
const.PIXEL_MAP_I_TO_A                     = 0x0C75
const.PIXEL_MAP_R_TO_R                     = 0x0C76
const.PIXEL_MAP_G_TO_G                     = 0x0C77
const.PIXEL_MAP_B_TO_B                     = 0x0C78
const.PIXEL_MAP_A_TO_A                     = 0x0C79
const.PACK_ALIGNMENT                       = 0x0D05
const.PACK_LSB_FIRST                       = 0x0D01
const.PACK_ROW_LENGTH                      = 0x0D02
const.PACK_SKIP_PIXELS                     = 0x0D04
const.PACK_SKIP_ROWS                       = 0x0D03
const.PACK_SWAP_BYTES                      = 0x0D00
const.UNPACK_ALIGNMENT                     = 0x0CF5
const.UNPACK_LSB_FIRST                     = 0x0CF1
const.UNPACK_ROW_LENGTH                    = 0x0CF2
const.UNPACK_SKIP_PIXELS                   = 0x0CF4
const.UNPACK_SKIP_ROWS                     = 0x0CF3
const.UNPACK_SWAP_BYTES                    = 0x0CF0
const.ZOOM_X                               = 0x0D16
const.ZOOM_Y                               = 0x0D17

-- Texture mapping
const.TEXTURE_ENV                          = 0x2300
const.TEXTURE_ENV_MODE                     = 0x2200
const.TEXTURE_1D                           = 0x0DE0
const.TEXTURE_2D                           = 0x0DE1
const.TEXTURE_WRAP_S                       = 0x2802
const.TEXTURE_WRAP_T                       = 0x2803
const.TEXTURE_MAG_FILTER                   = 0x2800
const.TEXTURE_MIN_FILTER                   = 0x2801
const.TEXTURE_ENV_COLOR                    = 0x2201
const.TEXTURE_GEN_S                        = 0x0C60
const.TEXTURE_GEN_T                        = 0x0C61
const.TEXTURE_GEN_MODE                     = 0x2500
const.TEXTURE_BORDER_COLOR                 = 0x1004
const.TEXTURE_WIDTH                        = 0x1000
const.TEXTURE_HEIGHT                       = 0x1001
const.TEXTURE_BORDER                       = 0x1005
const.TEXTURE_COMPONENTS                   = 0x1003
const.TEXTURE_RED_SIZE                     = 0x805C
const.TEXTURE_GREEN_SIZE                   = 0x805D
const.TEXTURE_BLUE_SIZE                    = 0x805E
const.TEXTURE_ALPHA_SIZE                   = 0x805F
const.TEXTURE_LUMINANCE_SIZE               = 0x8060
const.TEXTURE_INTENSITY_SIZE               = 0x8061
const.NEAREST_MIPMAP_NEAREST               = 0x2700
const.NEAREST_MIPMAP_LINEAR                = 0x2702
const.LINEAR_MIPMAP_NEAREST                = 0x2701
const.LINEAR_MIPMAP_LINEAR                 = 0x2703
const.OBJECT_LINEAR                        = 0x2401
const.OBJECT_PLANE                         = 0x2501
const.EYE_LINEAR                           = 0x2400
const.EYE_PLANE                            = 0x2502
const.SPHERE_MAP                           = 0x2402
const.DECAL                                = 0x2101
const.MODULATE                             = 0x2100
const.NEAREST                              = 0x2600
const.REPEAT                               = 0x2901
const.CLAMP                                = 0x2900
const.S                                    = 0x2000
const.T                                    = 0x2001
const.R                                    = 0x2002
const.Q                                    = 0x2003
const.TEXTURE_GEN_R                        = 0x0C62
const.TEXTURE_GEN_Q                        = 0x0C63

-- Utility
const.VENDOR                               = 0x1F00
const.RENDERER                             = 0x1F01
const.VERSION                              = 0x1F02
const.EXTENSIONS                           = 0x1F03

-- Errors
const.NO_ERROR                             = 0x0
const.INVALID_VALUE                        = 0x0501
const.INVALID_ENUM                         = 0x0500
const.INVALID_OPERATION                    = 0x0502
const.STACK_OVERFLOW                       = 0x0503
const.STACK_UNDERFLOW                      = 0x0504
const.OUT_OF_MEMORY                        = 0x0505

-- glPush/PopAttrib bits
const.CURRENT_BIT                          = 0x00000001
const.POINT_BIT                            = 0x00000002
const.LINE_BIT                             = 0x00000004
const.POLYGON_BIT                          = 0x00000008
const.POLYGON_STIPPLE_BIT                  = 0x00000010
const.PIXEL_MODE_BIT                       = 0x00000020
const.LIGHTING_BIT                         = 0x00000040
const.FOG_BIT                              = 0x00000080
const.DEPTH_BUFFER_BIT                     = 0x00000100
const.ACCUM_BUFFER_BIT                     = 0x00000200
const.STENCIL_BUFFER_BIT                   = 0x00000400
const.VIEWPORT_BIT                         = 0x00000800
const.TRANSFORM_BIT                        = 0x00001000
const.ENABLE_BIT                           = 0x00002000
const.COLOR_BUFFER_BIT                     = 0x00004000
const.HINT_BIT                             = 0x00008000
const.EVAL_BIT                             = 0x00010000
const.LIST_BIT                             = 0x00020000
const.TEXTURE_BIT                          = 0x00040000
const.SCISSOR_BIT                          = 0x00080000
const.ALL_ATTRIB_BITS                      = 0x000FFFFF


-- OpenGL 1.1
const.PROXY_TEXTURE_1D                     = 0x8063
const.PROXY_TEXTURE_2D                     = 0x8064
const.TEXTURE_PRIORITY                     = 0x8066
const.TEXTURE_RESIDENT                     = 0x8067
const.TEXTURE_BINDING_1D                   = 0x8068
const.TEXTURE_BINDING_2D                   = 0x8069
const.TEXTURE_INTERNAL_FORMAT              = 0x1003
const.ALPHA4                               = 0x803B
const.ALPHA8                               = 0x803C
const.ALPHA12                              = 0x803D
const.ALPHA16                              = 0x803E
const.LUMINANCE4                           = 0x803F
const.LUMINANCE8                           = 0x8040
const.LUMINANCE12                          = 0x8041
const.LUMINANCE16                          = 0x8042
const.LUMINANCE4_ALPHA4                    = 0x8043
const.LUMINANCE6_ALPHA2                    = 0x8044
const.LUMINANCE8_ALPHA8                    = 0x8045
const.LUMINANCE12_ALPHA4                   = 0x8046
const.LUMINANCE12_ALPHA12                  = 0x8047
const.LUMINANCE16_ALPHA16                  = 0x8048
const.INTENSITY                            = 0x8049
const.INTENSITY4                           = 0x804A
const.INTENSITY8                           = 0x804B
const.INTENSITY12                          = 0x804C
const.INTENSITY16                          = 0x804D
const.R3_G3_B2                             = 0x2A10
const.RGB4                                 = 0x804F
const.RGB5                                 = 0x8050
const.RGB8                                 = 0x8051
const.RGB10                                = 0x8052
const.RGB12                                = 0x8053
const.RGB16                                = 0x8054
const.RGBA2                                = 0x8055
const.RGBA4                                = 0x8056
const.RGB5_A1                              = 0x8057
const.RGBA8                                = 0x8058
const.RGB10_A2                             = 0x8059
const.RGBA12                               = 0x805A
const.RGBA16                               = 0x805B
const.CLIENT_PIXEL_STORE_BIT               = 0x00000001
const.CLIENT_VERTEX_ARRAY_BIT              = 0x00000002
const.ALL_CLIENT_ATTRIB_BITS               = 0xFFFFFFFF
const.CLIENT_ALL_ATTRIB_BITS               = 0xFFFFFFFF


-- OpenGL 1.2
const.RESCALE_NORMAL                       = 0x803A
const.CLAMP_TO_EDGE                        = 0x812F
const.MAX_ELEMENTS_VERTICES                = 0x80E8
const.MAX_ELEMENTS_INDICES                 = 0x80E9
const.BGR                                  = 0x80E0
const.BGRA                                 = 0x80E1
const.UNSIGNED_BYTE_3_3_2                  = 0x8032
const.UNSIGNED_BYTE_2_3_3_REV              = 0x8362
const.UNSIGNED_SHORT_5_6_5                 = 0x8363
const.UNSIGNED_SHORT_5_6_5_REV             = 0x8364
const.UNSIGNED_SHORT_4_4_4_4               = 0x8033
const.UNSIGNED_SHORT_4_4_4_4_REV           = 0x8365
const.UNSIGNED_SHORT_5_5_5_1               = 0x8034
const.UNSIGNED_SHORT_1_5_5_5_REV           = 0x8366
const.UNSIGNED_INT_8_8_8_8                 = 0x8035
const.UNSIGNED_INT_8_8_8_8_REV             = 0x8367
const.UNSIGNED_INT_10_10_10_2              = 0x8036
const.UNSIGNED_INT_2_10_10_10_REV          = 0x8368
const.LIGHT_MODEL_COLOR_CONTROL            = 0x81F8
const.SINGLE_COLOR                         = 0x81F9
const.SEPARATE_SPECULAR_COLOR              = 0x81FA
const.TEXTURE_MIN_LOD                      = 0x813A
const.TEXTURE_MAX_LOD                      = 0x813B
const.TEXTURE_BASE_LEVEL                   = 0x813C
const.TEXTURE_MAX_LEVEL                    = 0x813D
const.SMOOTH_POINT_SIZE_RANGE              = 0x0B12
const.SMOOTH_POINT_SIZE_GRANULARITY        = 0x0B13
const.SMOOTH_LINE_WIDTH_RANGE              = 0x0B22
const.SMOOTH_LINE_WIDTH_GRANULARITY        = 0x0B23
const.ALIASED_POINT_SIZE_RANGE             = 0x846D
const.ALIASED_LINE_WIDTH_RANGE             = 0x846E
const.PACK_SKIP_IMAGES                     = 0x806B
const.PACK_IMAGE_HEIGHT                    = 0x806C
const.UNPACK_SKIP_IMAGES                   = 0x806D
const.UNPACK_IMAGE_HEIGHT                  = 0x806E
const.TEXTURE_3D                           = 0x806F
const.PROXY_TEXTURE_3D                     = 0x8070
const.TEXTURE_DEPTH                        = 0x8071
const.TEXTURE_WRAP_R                       = 0x8072
const.MAX_3D_TEXTURE_SIZE                  = 0x8073
const.TEXTURE_BINDING_3D                   = 0x806A

-- OpenGL 1.2 imaging subset
-- GL_EXT_color_table
const.COLOR_TABLE                          = 0x80D0
const.POST_CONVOLUTION_COLOR_TABLE         = 0x80D1
const.POST_COLOR_MATRIX_COLOR_TABLE        = 0x80D2
const.PROXY_COLOR_TABLE                    = 0x80D3
const.PROXY_POST_CONVOLUTION_COLOR_TABLE   = 0x80D4
const.PROXY_POST_COLOR_MATRIX_COLOR_TABLE  = 0x80D5
const.COLOR_TABLE_SCALE                    = 0x80D6
const.COLOR_TABLE_BIAS                     = 0x80D7
const.COLOR_TABLE_FORMAT                   = 0x80D8
const.COLOR_TABLE_WIDTH                    = 0x80D9
const.COLOR_TABLE_RED_SIZE                 = 0x80DA
const.COLOR_TABLE_GREEN_SIZE               = 0x80DB
const.COLOR_TABLE_BLUE_SIZE                = 0x80DC
const.COLOR_TABLE_ALPHA_SIZE               = 0x80DD
const.COLOR_TABLE_LUMINANCE_SIZE           = 0x80DE
const.COLOR_TABLE_INTENSITY_SIZE           = 0x80DF
-- GL_EXT_convolution and GL_HP_convolution_border_modes
const.CONVOLUTION_1D                       = 0x8010
const.CONVOLUTION_2D                       = 0x8011
const.SEPARABLE_2D                         = 0x8012
const.CONVOLUTION_BORDER_MODE              = 0x8013
const.CONVOLUTION_FILTER_SCALE             = 0x8014
const.CONVOLUTION_FILTER_BIAS              = 0x8015
const.REDUCE                               = 0x8016
const.CONVOLUTION_FORMAT                   = 0x8017
const.CONVOLUTION_WIDTH                    = 0x8018
const.CONVOLUTION_HEIGHT                   = 0x8019
const.MAX_CONVOLUTION_WIDTH                = 0x801A
const.MAX_CONVOLUTION_HEIGHT               = 0x801B
const.POST_CONVOLUTION_RED_SCALE           = 0x801C
const.POST_CONVOLUTION_GREEN_SCALE         = 0x801D
const.POST_CONVOLUTION_BLUE_SCALE          = 0x801E
const.POST_CONVOLUTION_ALPHA_SCALE         = 0x801F
const.POST_CONVOLUTION_RED_BIAS            = 0x8020
const.POST_CONVOLUTION_GREEN_BIAS          = 0x8021
const.POST_CONVOLUTION_BLUE_BIAS           = 0x8022
const.POST_CONVOLUTION_ALPHA_BIAS          = 0x8023
const.CONSTANT_BORDER                      = 0x8151
const.REPLICATE_BORDER                     = 0x8153
const.CONVOLUTION_BORDER_COLOR             = 0x8154
-- GL_SGI_color_matrix
const.COLOR_MATRIX                         = 0x80B1
const.COLOR_MATRIX_STACK_DEPTH             = 0x80B2
const.MAX_COLOR_MATRIX_STACK_DEPTH         = 0x80B3
const.POST_COLOR_MATRIX_RED_SCALE          = 0x80B4
const.POST_COLOR_MATRIX_GREEN_SCALE        = 0x80B5
const.POST_COLOR_MATRIX_BLUE_SCALE         = 0x80B6
const.POST_COLOR_MATRIX_ALPHA_SCALE        = 0x80B7
const.POST_COLOR_MATRIX_RED_BIAS           = 0x80B8
const.POST_COLOR_MATRIX_GREEN_BIAS         = 0x80B9
const.POST_COLOR_MATRIX_BLUE_BIAS          = 0x80BA
const.POST_COLOR_MATRIX_ALPHA_BIAS         = 0x80BB
-- GL_EXT_histogram
const.HISTOGRAM                            = 0x8024
const.PROXY_HISTOGRAM                      = 0x8025
const.HISTOGRAM_WIDTH                      = 0x8026
const.HISTOGRAM_FORMAT                     = 0x8027
const.HISTOGRAM_RED_SIZE                   = 0x8028
const.HISTOGRAM_GREEN_SIZE                 = 0x8029
const.HISTOGRAM_BLUE_SIZE                  = 0x802A
const.HISTOGRAM_ALPHA_SIZE                 = 0x802B
const.HISTOGRAM_LUMINANCE_SIZE             = 0x802C
const.HISTOGRAM_SINK                       = 0x802D
const.MINMAX                               = 0x802E
const.MINMAX_FORMAT                        = 0x802F
const.MINMAX_SINK                          = 0x8030
const.TABLE_TOO_LARGE                      = 0x8031
-- GL_EXT_blend_color, GL_EXT_blend_minmax
const.BLEND_EQUATION                       = 0x8009
const.MIN                                  = 0x8007
const.MAX                                  = 0x8008
const.FUNC_ADD                             = 0x8006
const.FUNC_SUBTRACT                        = 0x800A
const.FUNC_REVERSE_SUBTRACT                = 0x800B
const.BLEND_COLOR                          = 0x8005


-- OpenGL 1.3
-- multitexture
const.TEXTURE0                             = 0x84C0
const.TEXTURE1                             = 0x84C1
const.TEXTURE2                             = 0x84C2
const.TEXTURE3                             = 0x84C3
const.TEXTURE4                             = 0x84C4
const.TEXTURE5                             = 0x84C5
const.TEXTURE6                             = 0x84C6
const.TEXTURE7                             = 0x84C7
const.TEXTURE8                             = 0x84C8
const.TEXTURE9                             = 0x84C9
const.TEXTURE10                            = 0x84CA
const.TEXTURE11                            = 0x84CB
const.TEXTURE12                            = 0x84CC
const.TEXTURE13                            = 0x84CD
const.TEXTURE14                            = 0x84CE
const.TEXTURE15                            = 0x84CF
const.TEXTURE16                            = 0x84D0
const.TEXTURE17                            = 0x84D1
const.TEXTURE18                            = 0x84D2
const.TEXTURE19                            = 0x84D3
const.TEXTURE20                            = 0x84D4
const.TEXTURE21                            = 0x84D5
const.TEXTURE22                            = 0x84D6
const.TEXTURE23                            = 0x84D7
const.TEXTURE24                            = 0x84D8
const.TEXTURE25                            = 0x84D9
const.TEXTURE26                            = 0x84DA
const.TEXTURE27                            = 0x84DB
const.TEXTURE28                            = 0x84DC
const.TEXTURE29                            = 0x84DD
const.TEXTURE30                            = 0x84DE
const.TEXTURE31                            = 0x84DF
const.ACTIVE_TEXTURE                       = 0x84E0
const.CLIENT_ACTIVE_TEXTURE                = 0x84E1
const.MAX_TEXTURE_UNITS                    = 0x84E2
-- texture_cube_map
const.NORMAL_MAP                           = 0x8511
const.REFLECTION_MAP                       = 0x8512
const.TEXTURE_CUBE_MAP                     = 0x8513
const.TEXTURE_BINDING_CUBE_MAP             = 0x8514
const.TEXTURE_CUBE_MAP_POSITIVE_X          = 0x8515
const.TEXTURE_CUBE_MAP_NEGATIVE_X          = 0x8516
const.TEXTURE_CUBE_MAP_POSITIVE_Y          = 0x8517
const.TEXTURE_CUBE_MAP_NEGATIVE_Y          = 0x8518
const.TEXTURE_CUBE_MAP_POSITIVE_Z          = 0x8519
const.TEXTURE_CUBE_MAP_NEGATIVE_Z          = 0x851A
const.PROXY_TEXTURE_CUBE_MAP               = 0x851B
const.MAX_CUBE_MAP_TEXTURE_SIZE            = 0x851C
-- texture_compression
const.COMPRESSED_ALPHA                     = 0x84E9
const.COMPRESSED_LUMINANCE                 = 0x84EA
const.COMPRESSED_LUMINANCE_ALPHA           = 0x84EB
const.COMPRESSED_INTENSITY                 = 0x84EC
const.COMPRESSED_RGB                       = 0x84ED
const.COMPRESSED_RGBA                      = 0x84EE
const.TEXTURE_COMPRESSION_HINT             = 0x84EF
const.TEXTURE_COMPRESSED_IMAGE_SIZE        = 0x86A0
const.TEXTURE_COMPRESSED                   = 0x86A1
const.NUM_COMPRESSED_TEXTURE_FORMATS       = 0x86A2
const.COMPRESSED_TEXTURE_FORMATS           = 0x86A3
-- multisample
const.MULTISAMPLE                          = 0x809D
const.SAMPLE_ALPHA_TO_COVERAGE             = 0x809E
const.SAMPLE_ALPHA_TO_ONE                  = 0x809F
const.SAMPLE_COVERAGE                      = 0x80A0
const.SAMPLE_BUFFERS                       = 0x80A8
const.SAMPLES                              = 0x80A9
const.SAMPLE_COVERAGE_VALUE                = 0x80AA
const.SAMPLE_COVERAGE_INVERT               = 0x80AB
const.MULTISAMPLE_BIT                      = 0x20000000
-- transpose_matrix
const.TRANSPOSE_MODELVIEW_MATRIX           = 0x84E3
const.TRANSPOSE_PROJECTION_MATRIX          = 0x84E4
const.TRANSPOSE_TEXTURE_MATRIX             = 0x84E5
const.TRANSPOSE_COLOR_MATRIX               = 0x84E6
-- texture_env_combine
const.COMBINE                              = 0x8570
const.COMBINE_RGB                          = 0x8571
const.COMBINE_ALPHA                        = 0x8572
const.SOURCE0_RGB                          = 0x8580
const.SOURCE1_RGB                          = 0x8581
const.SOURCE2_RGB                          = 0x8582
const.SOURCE0_ALPHA                        = 0x8588
const.SOURCE1_ALPHA                        = 0x8589
const.SOURCE2_ALPHA                        = 0x858A
const.OPERAND0_RGB                         = 0x8590
const.OPERAND1_RGB                         = 0x8591
const.OPERAND2_RGB                         = 0x8592
const.OPERAND0_ALPHA                       = 0x8598
const.OPERAND1_ALPHA                       = 0x8599
const.OPERAND2_ALPHA                       = 0x859A
const.RGB_SCALE                            = 0x8573
const.ADD_SIGNED                           = 0x8574
const.INTERPOLATE                          = 0x8575
const.SUBTRACT                             = 0x84E7
const.CONSTANT                             = 0x8576
const.PRIMARY_COLOR                        = 0x8577
const.PREVIOUS                             = 0x8578
-- texture_env_dot3
const.DOT3_RGB                             = 0x86AE
const.DOT3_RGBA                            = 0x86AF
-- texture_border_clamp
const.CLAMP_TO_BORDER                      = 0x812D


local header = [[
  typedef unsigned int   GLenum;
  typedef unsigned char  GLboolean;
  typedef unsigned int   GLbitfield;
  typedef void           GLvoid;
  typedef signed char    GLbyte;
  typedef short          GLshort;
  typedef int            GLint;
  typedef unsigned char  GLubyte;
  typedef unsigned short GLushort;
  typedef unsigned int   GLuint;
  typedef int            GLsizei;
  typedef float          GLfloat;
  typedef float          GLclampf;
  typedef double         GLdouble;
  typedef double         GLclampd;

  /* Miscellaneous */
  void glClearIndex(GLfloat c);
  void glClearColor(GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
  void glClear(GLbitfield mask);
  void glIndexMask(GLuint mask);
  void glColorMask(GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);
  void glAlphaFunc(GLenum func, GLclampf ref);
  void glBlendFunc(GLenum sfactor, GLenum dfactor);
  void glLogicOp(GLenum opcode);
  void glCullFace(GLenum mode);
  void glFrontFace(GLenum mode);
  void glPointSize(GLfloat size);
  void glLineWidth(GLfloat width);
  void glLineStipple(GLint factor, GLushort pattern);
  void glPolygonMode(GLenum face, GLenum mode);
  void glPolygonOffset(GLfloat factor, GLfloat units);
  void glPolygonStipple(const GLubyte *mask);
  void glGetPolygonStipple(GLubyte *mask);
  void glEdgeFlag(GLboolean flag);
  void glEdgeFlagv(const GLboolean *flag);
  void glScissor(GLint x, GLint y, GLsizei width, GLsizei height);
  void glClipPlane(GLenum plane, const GLdouble *equation);
  void glGetClipPlane(GLenum plane, GLdouble *equation);
  void glDrawBuffer(GLenum mode);
  void glReadBuffer(GLenum mode);
  void glEnable(GLenum cap);
  void glDisable(GLenum cap);
  GLboolean glIsEnabled(GLenum cap);
  void glEnableClientState(GLenum cap);  /* 1.1 */
  void glDisableClientState(GLenum cap);  /* 1.1 */
  void glGetBooleanv(GLenum pname, GLboolean *params);
  void glGetDoublev(GLenum pname, GLdouble *params);
  void glGetFloatv(GLenum pname, GLfloat *params);
  void glGetIntegerv(GLenum pname, GLint *params);
  void glPushAttrib(GLbitfield mask);
  void glPopAttrib(void);
  void glPushClientAttrib(GLbitfield mask);  /* 1.1 */
  void glPopClientAttrib(void);  /* 1.1 */
  GLint glRenderMode(GLenum mode);
  GLenum glGetError(void);
  const GLubyte* glGetString(GLenum name);
  void glFinish(void);
  void glFlush(void);
  void glHint(GLenum target, GLenum mode);

  /* Depth Buffer */
  void glClearDepth(GLclampd depth);
  void glDepthFunc(GLenum func);
  void glDepthMask(GLboolean flag);
  void glDepthRange(GLclampd near_val, GLclampd far_val);

  /* Accumulation Buffer */
  void glClearAccum(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
  void glAccum(GLenum op, GLfloat value);

  /* Transformation */
  void glMatrixMode(GLenum mode);
  void glOrtho(GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble near_val, GLdouble far_val);
  void glFrustum(GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble near_val, GLdouble far_val);
  void glViewport(GLint x, GLint y, GLsizei width, GLsizei height);
  void glPushMatrix(void);
  void glPopMatrix(void);
  void glLoadIdentity(void);
  void glLoadMatrixd(const GLdouble *m);
  void glLoadMatrixf(const GLfloat *m);
  void glMultMatrixd(const GLdouble *m);
  void glMultMatrixf(const GLfloat *m);
  void glRotated(GLdouble angle, GLdouble x, GLdouble y, GLdouble z);
  void glRotatef(GLfloat angle, GLfloat x, GLfloat y, GLfloat z);
  void glScaled(GLdouble x, GLdouble y, GLdouble z);
  void glScalef(GLfloat x, GLfloat y, GLfloat z);
  void glTranslated(GLdouble x, GLdouble y, GLdouble z);
  void glTranslatef(GLfloat x, GLfloat y, GLfloat z);

  /* Display Lists */
  GLboolean glIsList(GLuint list);
  void glDeleteLists(GLuint list, GLsizei range);
  GLuint glGenLists(GLsizei range);
  void glNewList(GLuint list, GLenum mode);
  void glEndList(void);
  void glCallList(GLuint list);
  void glCallLists(GLsizei n, GLenum type, const GLvoid *lists);
  void glListBase(GLuint base);

  /* Drawing Functions */
  void glBegin(GLenum mode);
  void glEnd(void);
  void glVertex2d(GLdouble x, GLdouble y);
  void glVertex2f(GLfloat x, GLfloat y);
  void glVertex2i(GLint x, GLint y);
  void glVertex2s(GLshort x, GLshort y);
  void glVertex3d(GLdouble x, GLdouble y, GLdouble z);
  void glVertex3f(GLfloat x, GLfloat y, GLfloat z);
  void glVertex3i(GLint x, GLint y, GLint z);
  void glVertex3s(GLshort x, GLshort y, GLshort z);
  void glVertex4d(GLdouble x, GLdouble y, GLdouble z, GLdouble w);
  void glVertex4f(GLfloat x, GLfloat y, GLfloat z, GLfloat w);
  void glVertex4i(GLint x, GLint y, GLint z, GLint w);
  void glVertex4s(GLshort x, GLshort y, GLshort z, GLshort w);
  void glVertex2dv(const GLdouble *v);
  void glVertex2fv(const GLfloat *v);
  void glVertex2iv(const GLint *v);
  void glVertex2sv(const GLshort *v);
  void glVertex3dv(const GLdouble *v);
  void glVertex3fv(const GLfloat *v);
  void glVertex3iv(const GLint *v);
  void glVertex3sv(const GLshort *v);
  void glVertex4dv(const GLdouble *v);
  void glVertex4fv(const GLfloat *v);
  void glVertex4iv(const GLint *v);
  void glVertex4sv(const GLshort *v);
  void glNormal3b(GLbyte nx, GLbyte ny, GLbyte nz);
  void glNormal3d(GLdouble nx, GLdouble ny, GLdouble nz);
  void glNormal3f(GLfloat nx, GLfloat ny, GLfloat nz);
  void glNormal3i(GLint nx, GLint ny, GLint nz);
  void glNormal3s(GLshort nx, GLshort ny, GLshort nz);
  void glNormal3bv(const GLbyte *v);
  void glNormal3dv(const GLdouble *v);
  void glNormal3fv(const GLfloat *v);
  void glNormal3iv(const GLint *v);
  void glNormal3sv(const GLshort *v);
  void glIndexd(GLdouble c);
  void glIndexf(GLfloat c);
  void glIndexi(GLint c);
  void glIndexs(GLshort c);
  void glIndexub(GLubyte c);  /* 1.1 */
  void glIndexdv(const GLdouble *c);
  void glIndexfv(const GLfloat *c);
  void glIndexiv(const GLint *c);
  void glIndexsv(const GLshort *c);
  void glIndexubv(const GLubyte *c);  /* 1.1 */
  void glColor3b(GLbyte red, GLbyte green, GLbyte blue);
  void glColor3d(GLdouble red, GLdouble green, GLdouble blue);
  void glColor3f(GLfloat red, GLfloat green, GLfloat blue);
  void glColor3i(GLint red, GLint green, GLint blue);
  void glColor3s(GLshort red, GLshort green, GLshort blue);
  void glColor3ub(GLubyte red, GLubyte green, GLubyte blue);
  void glColor3ui(GLuint red, GLuint green, GLuint blue);
  void glColor3us(GLushort red, GLushort green, GLushort blue);
  void glColor4b(GLbyte red, GLbyte green, GLbyte blue, GLbyte alpha);
  void glColor4d(GLdouble red, GLdouble green, GLdouble blue, GLdouble alpha);
  void glColor4f(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
  void glColor4i(GLint red, GLint green, GLint blue, GLint alpha);
  void glColor4s(GLshort red, GLshort green, GLshort blue, GLshort alpha);
  void glColor4ub(GLubyte red, GLubyte green, GLubyte blue, GLubyte alpha);
  void glColor4ui(GLuint red, GLuint green, GLuint blue, GLuint alpha);
  void glColor4us(GLushort red, GLushort green, GLushort blue, GLushort alpha);
  void glColor3bv(const GLbyte *v);
  void glColor3dv(const GLdouble *v);
  void glColor3fv(const GLfloat *v);
  void glColor3iv(const GLint *v);
  void glColor3sv(const GLshort *v);
  void glColor3ubv(const GLubyte *v);
  void glColor3uiv(const GLuint *v);
  void glColor3usv(const GLushort *v);
  void glColor4bv(const GLbyte *v);
  void glColor4dv(const GLdouble *v);
  void glColor4fv(const GLfloat *v);
  void glColor4iv(const GLint *v);
  void glColor4sv(const GLshort *v);
  void glColor4ubv(const GLubyte *v);
  void glColor4uiv(const GLuint *v);
  void glColor4usv(const GLushort *v);
  void glTexCoord1d(GLdouble s);
  void glTexCoord1f(GLfloat s);
  void glTexCoord1i(GLint s);
  void glTexCoord1s(GLshort s);
  void glTexCoord2d(GLdouble s, GLdouble t);
  void glTexCoord2f(GLfloat s, GLfloat t);
  void glTexCoord2i(GLint s, GLint t);
  void glTexCoord2s(GLshort s, GLshort t);
  void glTexCoord3d(GLdouble s, GLdouble t, GLdouble r);
  void glTexCoord3f(GLfloat s, GLfloat t, GLfloat r);
  void glTexCoord3i(GLint s, GLint t, GLint r);
  void glTexCoord3s(GLshort s, GLshort t, GLshort r);
  void glTexCoord4d(GLdouble s, GLdouble t, GLdouble r, GLdouble q);
  void glTexCoord4f(GLfloat s, GLfloat t, GLfloat r, GLfloat q);
  void glTexCoord4i(GLint s, GLint t, GLint r, GLint q);
  void glTexCoord4s(GLshort s, GLshort t, GLshort r, GLshort q);
  void glTexCoord1dv(const GLdouble *v);
  void glTexCoord1fv(const GLfloat *v);
  void glTexCoord1iv(const GLint *v);
  void glTexCoord1sv(const GLshort *v);
  void glTexCoord2dv(const GLdouble *v);
  void glTexCoord2fv(const GLfloat *v);
  void glTexCoord2iv(const GLint *v);
  void glTexCoord2sv(const GLshort *v);
  void glTexCoord3dv(const GLdouble *v);
  void glTexCoord3fv(const GLfloat *v);
  void glTexCoord3iv(const GLint *v);
  void glTexCoord3sv(const GLshort *v);
  void glTexCoord4dv(const GLdouble *v);
  void glTexCoord4fv(const GLfloat *v);
  void glTexCoord4iv(const GLint *v);
  void glTexCoord4sv(const GLshort *v);
  void glRasterPos2d(GLdouble x, GLdouble y);
  void glRasterPos2f(GLfloat x, GLfloat y);
  void glRasterPos2i(GLint x, GLint y);
  void glRasterPos2s(GLshort x, GLshort y);
  void glRasterPos3d(GLdouble x, GLdouble y, GLdouble z);
  void glRasterPos3f(GLfloat x, GLfloat y, GLfloat z);
  void glRasterPos3i(GLint x, GLint y, GLint z);
  void glRasterPos3s(GLshort x, GLshort y, GLshort z);
  void glRasterPos4d(GLdouble x, GLdouble y, GLdouble z, GLdouble w);
  void glRasterPos4f(GLfloat x, GLfloat y, GLfloat z, GLfloat w);
  void glRasterPos4i(GLint x, GLint y, GLint z, GLint w);
  void glRasterPos4s(GLshort x, GLshort y, GLshort z, GLshort w);
  void glRasterPos2dv(const GLdouble *v);
  void glRasterPos2fv(const GLfloat *v);
  void glRasterPos2iv(const GLint *v);
  void glRasterPos2sv(const GLshort *v);
  void glRasterPos3dv(const GLdouble *v);
  void glRasterPos3fv(const GLfloat *v);
  void glRasterPos3iv(const GLint *v);
  void glRasterPos3sv(const GLshort *v);
  void glRasterPos4dv(const GLdouble *v);
  void glRasterPos4fv(const GLfloat *v);
  void glRasterPos4iv(const GLint *v);
  void glRasterPos4sv(const GLshort *v);
  void glRectd(GLdouble x1, GLdouble y1, GLdouble x2, GLdouble y2);
  void glRectf(GLfloat x1, GLfloat y1, GLfloat x2, GLfloat y2);
  void glRecti(GLint x1, GLint y1, GLint x2, GLint y2);
  void glRects(GLshort x1, GLshort y1, GLshort x2, GLshort y2);
  void glRectdv(const GLdouble *v1, const GLdouble *v2);
  void glRectfv(const GLfloat *v1, const GLfloat *v2);
  void glRectiv(const GLint *v1, const GLint *v2);
  void glRectsv(const GLshort *v1, const GLshort *v2);

  /* Lighting */
  void glShadeModel(GLenum mode);
  void glLightf(GLenum light, GLenum pname, GLfloat param);
  void glLighti(GLenum light, GLenum pname, GLint param);
  void glLightfv(GLenum light, GLenum pname, const GLfloat *params);
  void glLightiv(GLenum light, GLenum pname, const GLint *params);
  void glGetLightfv(GLenum light, GLenum pname, GLfloat *params);
  void glGetLightiv(GLenum light, GLenum pname, GLint *params);
  void glLightModelf(GLenum pname, GLfloat param);
  void glLightModeli(GLenum pname, GLint param);
  void glLightModelfv(GLenum pname, const GLfloat *params);
  void glLightModeliv(GLenum pname, const GLint *params);
  void glMaterialf(GLenum face, GLenum pname, GLfloat param);
  void glMateriali(GLenum face, GLenum pname, GLint param);
  void glMaterialfv(GLenum face, GLenum pname, const GLfloat *params);
  void glMaterialiv(GLenum face, GLenum pname, const GLint *params);
  void glGetMaterialfv(GLenum face, GLenum pname, GLfloat *params);
  void glGetMaterialiv(GLenum face, GLenum pname, GLint *params);
  void glColorMaterial(GLenum face, GLenum mode);

  /* Raster functions */
  void glPixelZoom(GLfloat xfactor, GLfloat yfactor);
  void glPixelStoref(GLenum pname, GLfloat param);
  void glPixelStorei(GLenum pname, GLint param);
  void glPixelTransferf(GLenum pname, GLfloat param);
  void glPixelTransferi(GLenum pname, GLint param);
  void glPixelMapfv(GLenum map, GLint mapsize, const GLfloat *values);
  void glPixelMapuiv(GLenum map, GLint mapsize, const GLuint *values);
  void glPixelMapusv(GLenum map, GLint mapsize, const GLushort *values);
  void glGetPixelMapfv(GLenum map, GLfloat *values);
  void glGetPixelMapuiv(GLenum map, GLuint *values);
  void glGetPixelMapusv(GLenum map, GLushort *values);
  void glBitmap(GLsizei width, GLsizei height, GLfloat xorig, GLfloat yorig, GLfloat xmove, GLfloat ymove, const GLubyte *bitmap);
  void glReadPixels(GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid *pixels);
  void glDrawPixels(GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels);
  void glCopyPixels(GLint x, GLint y, GLsizei width, GLsizei height, GLenum type);

  /* Stenciling */
  void glStencilFunc(GLenum func, GLint ref, GLuint mask);
  void glStencilMask(GLuint mask);
  void glStencilOp(GLenum fail, GLenum zfail, GLenum zpass);
  void glClearStencil(GLint s);

  /* Texture mapping */
  void glTexGend(GLenum coord, GLenum pname, GLdouble param);
  void glTexGenf(GLenum coord, GLenum pname, GLfloat param);
  void glTexGeni(GLenum coord, GLenum pname, GLint param);
  void glTexGendv(GLenum coord, GLenum pname, const GLdouble *params);
  void glTexGenfv(GLenum coord, GLenum pname, const GLfloat *params);
  void glTexGeniv(GLenum coord, GLenum pname, const GLint *params);
  void glGetTexGendv(GLenum coord, GLenum pname, GLdouble *params);
  void glGetTexGenfv(GLenum coord, GLenum pname, GLfloat *params);
  void glGetTexGeniv(GLenum coord, GLenum pname, GLint *params);
  void glTexEnvf(GLenum target, GLenum pname, GLfloat param);
  void glTexEnvi(GLenum target, GLenum pname, GLint param);
  void glTexEnvfv(GLenum target, GLenum pname, const GLfloat *params);
  void glTexEnviv(GLenum target, GLenum pname, const GLint *params);
  void glGetTexEnvfv(GLenum target, GLenum pname, GLfloat *params);
  void glGetTexEnviv(GLenum target, GLenum pname, GLint *params);
  void glTexParameterf(GLenum target, GLenum pname, GLfloat param);
  void glTexParameteri(GLenum target, GLenum pname, GLint param);
  void glTexParameterfv(GLenum target, GLenum pname, const GLfloat *params);
  void glTexParameteriv(GLenum target, GLenum pname, const GLint *params);
  void glGetTexParameterfv(GLenum target, GLenum pname, GLfloat *params);
  void glGetTexParameteriv(GLenum target, GLenum pname, GLint *params);
  void glGetTexLevelParameterfv(GLenum target, GLint level, GLenum pname, GLfloat *params);
  void glGetTexLevelParameteriv(GLenum target, GLint level, GLenum pname, GLint *params);
  void glTexImage1D(GLenum target, GLint level, GLint internalFormat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
  void glTexImage2D(GLenum target, GLint level, GLint internalFormat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
  void glGetTexImage(GLenum target, GLint level, GLenum format, GLenum type, GLvoid *pixels);

  /* Evaluators */
  void glMap1d(GLenum target, GLdouble u1, GLdouble u2, GLint stride, GLint order, const GLdouble *points);
  void glMap1f(GLenum target, GLfloat u1, GLfloat u2, GLint stride, GLint order, const GLfloat *points);
  void glMap2d(GLenum target, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, const GLdouble *points);
  void glMap2f(GLenum target, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, const GLfloat *points);
  void glGetMapdv(GLenum target, GLenum query, GLdouble *v);
  void glGetMapfv(GLenum target, GLenum query, GLfloat *v);
  void glGetMapiv(GLenum target, GLenum query, GLint *v);
  void glEvalCoord1d(GLdouble u);
  void glEvalCoord1f(GLfloat u);
  void glEvalCoord1dv(const GLdouble *u);
  void glEvalCoord1fv(const GLfloat *u);
  void glEvalCoord2d(GLdouble u, GLdouble v);
  void glEvalCoord2f(GLfloat u, GLfloat v);
  void glEvalCoord2dv(const GLdouble *u);
  void glEvalCoord2fv(const GLfloat *u);
  void glMapGrid1d(GLint un, GLdouble u1, GLdouble u2);
  void glMapGrid1f(GLint un, GLfloat u1, GLfloat u2);
  void glMapGrid2d(GLint un, GLdouble u1, GLdouble u2, GLint vn, GLdouble v1, GLdouble v2);
  void glMapGrid2f(GLint un, GLfloat u1, GLfloat u2, GLint vn, GLfloat v1, GLfloat v2);
  void glEvalPoint1(GLint i);
  void glEvalPoint2(GLint i, GLint j);
  void glEvalMesh1(GLenum mode, GLint i1, GLint i2);
  void glEvalMesh2(GLenum mode, GLint i1, GLint i2, GLint j1, GLint j2);

  /* Fog */
  void glFogf(GLenum pname, GLfloat param);
  void glFogi(GLenum pname, GLint param);
  void glFogfv(GLenum pname, const GLfloat *params);
  void glFogiv(GLenum pname, const GLint *params);

  /* Selection and Feedback */
  void glFeedbackBuffer(GLsizei size, GLenum type, GLfloat *buffer);
  void glPassThrough(GLfloat token);
  void glSelectBuffer(GLsizei size, GLuint *buffer);
  void glInitNames(void);
  void glLoadName(GLuint name);
  void glPushName(GLuint name);
  void glPopName(void);


  /* 1.1 functions */
  /* texture objects */
  void glGenTextures(GLsizei n, GLuint *textures);
  void glDeleteTextures(GLsizei n, const GLuint *textures);
  void glBindTexture(GLenum target, GLuint texture);
  void glPrioritizeTextures(GLsizei n, const GLuint *textures, const GLclampf *priorities);
  GLboolean glAreTexturesResident(GLsizei n, const GLuint *textures, GLboolean *residences);
  GLboolean glIsTexture(GLuint texture);
  /* texture mapping */
  void glTexSubImage1D(GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const GLvoid *pixels);
  void glTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels);
  void glCopyTexImage1D(GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
  void glCopyTexImage2D(GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
  void glCopyTexSubImage1D(GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
  void glCopyTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
  /* vertex arrays */
  void glVertexPointer(GLint size, GLenum type, GLsizei stride, const GLvoid *ptr);
  void glNormalPointer(GLenum type, GLsizei stride, const GLvoid *ptr);
  void glColorPointer(GLint size, GLenum type, GLsizei stride, const GLvoid *ptr);
  void glIndexPointer(GLenum type, GLsizei stride, const GLvoid *ptr);
  void glTexCoordPointer(GLint size, GLenum type, GLsizei stride, const GLvoid *ptr);
  void glEdgeFlagPointer(GLsizei stride, const GLvoid *ptr);
  void glGetPointerv(GLenum pname, GLvoid **params);
  void glArrayElement(GLint i);
  void glDrawArrays(GLenum mode, GLint first, GLsizei count);
  void glDrawElements(GLenum mode, GLsizei count, GLenum type, const GLvoid *indices);
  void glInterleavedArrays(GLenum format, GLsizei stride, const GLvoid *pointer);

  /* 1.2 functions */
  void glDrawRangeElements(GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices);
  void glTexImage3D(GLenum target, GLint level, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
  void glTexSubImage3D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const GLvoid *pixels);
  void glCopyTexSubImage3D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);

  /* 1.2 imaging extension functions */
  void glColorTable(GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const GLvoid *table);
  void glColorSubTable(GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, const GLvoid *data);
  void glColorTableParameteriv(GLenum target, GLenum pname, const GLint *params);
  void glColorTableParameterfv(GLenum target, GLenum pname, const GLfloat *params);
  void glCopyColorSubTable(GLenum target, GLsizei start, GLint x, GLint y, GLsizei width);
  void glCopyColorTable(GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
  void glGetColorTable(GLenum target, GLenum format, GLenum type, GLvoid *table);
  void glGetColorTableParameterfv(GLenum target, GLenum pname, GLfloat *params);
  void glGetColorTableParameteriv(GLenum target, GLenum pname, GLint *params);
  void glBlendEquation(GLenum mode);
  void glBlendColor(GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha);
  void glHistogram(GLenum target, GLsizei width, GLenum internalformat, GLboolean sink);
  void glResetHistogram(GLenum target);
  void glGetHistogram(GLenum target, GLboolean reset, GLenum format, GLenum type, GLvoid *values);
  void glGetHistogramParameterfv(GLenum target, GLenum pname, GLfloat *params);
  void glGetHistogramParameteriv(GLenum target, GLenum pname, GLint *params);
  void glMinmax(GLenum target, GLenum internalformat, GLboolean sink);
  void glResetMinmax(GLenum target);
  void glGetMinmax(GLenum target, GLboolean reset, GLenum format, GLenum types, GLvoid *values);
  void glGetMinmaxParameterfv(GLenum target, GLenum pname, GLfloat *params);
  void glGetMinmaxParameteriv(GLenum target, GLenum pname, GLint *params);
  void glConvolutionFilter1D(GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const GLvoid *image);
  void glConvolutionFilter2D(GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *image);
  void glConvolutionParameterf(GLenum target, GLenum pname, GLfloat params);
  void glConvolutionParameterfv(GLenum target, GLenum pname, const GLfloat *params);
  void glConvolutionParameteri(GLenum target, GLenum pname, GLint params);
  void glConvolutionParameteriv(GLenum target, GLenum pname, const GLint *params);
  void glCopyConvolutionFilter1D(GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width);
  void glCopyConvolutionFilter2D(GLenum target, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height);
  void glGetConvolutionFilter(GLenum target, GLenum format, GLenum type, GLvoid *image);
  void glGetConvolutionParameterfv(GLenum target, GLenum pname, GLfloat *params);
  void glGetConvolutionParameteriv(GLenum target, GLenum pname, GLint *params);
  void glSeparableFilter2D(GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *row, const GLvoid *column);
  void glGetSeparableFilter(GLenum target, GLenum format, GLenum type, GLvoid *row, GLvoid *column, GLvoid *span);

  /* 1.3 functions */
  void glActiveTexture(GLenum texture);
  void glClientActiveTexture(GLenum texture);
  void glCompressedTexImage1D(GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const GLvoid *data);
  void glCompressedTexImage2D(GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid *data);
  void glCompressedTexImage3D(GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const GLvoid *data);
  void glCompressedTexSubImage1D(GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const GLvoid *data);
  void glCompressedTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid *data);
  void glCompressedTexSubImage3D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const GLvoid *data);
  void glGetCompressedTexImage(GLenum target, GLint lod, GLvoid *img);
  void glMultiTexCoord1d(GLenum target, GLdouble s);
  void glMultiTexCoord1dv(GLenum target, const GLdouble *v);
  void glMultiTexCoord1f(GLenum target, GLfloat s);
  void glMultiTexCoord1fv(GLenum target, const GLfloat *v);
  void glMultiTexCoord1i(GLenum target, GLint s);
  void glMultiTexCoord1iv(GLenum target, const GLint *v);
  void glMultiTexCoord1s(GLenum target, GLshort s);
  void glMultiTexCoord1sv(GLenum target, const GLshort *v);
  void glMultiTexCoord2d(GLenum target, GLdouble s, GLdouble t);
  void glMultiTexCoord2dv(GLenum target, const GLdouble *v);
  void glMultiTexCoord2f(GLenum target, GLfloat s, GLfloat t);
  void glMultiTexCoord2fv(GLenum target, const GLfloat *v);
  void glMultiTexCoord2i(GLenum target, GLint s, GLint t);
  void glMultiTexCoord2iv(GLenum target, const GLint *v);
  void glMultiTexCoord2s(GLenum target, GLshort s, GLshort t);
  void glMultiTexCoord2sv(GLenum target, const GLshort *v);
  void glMultiTexCoord3d(GLenum target, GLdouble s, GLdouble t, GLdouble r);
  void glMultiTexCoord3dv(GLenum target, const GLdouble *v);
  void glMultiTexCoord3f(GLenum target, GLfloat s, GLfloat t, GLfloat r);
  void glMultiTexCoord3fv(GLenum target, const GLfloat *v);
  void glMultiTexCoord3i(GLenum target, GLint s, GLint t, GLint r);
  void glMultiTexCoord3iv(GLenum target, const GLint *v);
  void glMultiTexCoord3s(GLenum target, GLshort s, GLshort t, GLshort r);
  void glMultiTexCoord3sv(GLenum target, const GLshort *v);
  void glMultiTexCoord4d(GLenum target, GLdouble s, GLdouble t, GLdouble r, GLdouble q);
  void glMultiTexCoord4dv(GLenum target, const GLdouble *v);
  void glMultiTexCoord4f(GLenum target, GLfloat s, GLfloat t, GLfloat r, GLfloat q);
  void glMultiTexCoord4fv(GLenum target, const GLfloat *v);
  void glMultiTexCoord4i(GLenum target, GLint s, GLint t, GLint r, GLint q);
  void glMultiTexCoord4iv(GLenum target, const GLint *v);
  void glMultiTexCoord4s(GLenum target, GLshort s, GLshort t, GLshort r, GLshort q);
  void glMultiTexCoord4sv(GLenum target, const GLshort *v);
  void glLoadTransposeMatrixd(const GLdouble m[16]);
  void glLoadTransposeMatrixf(const GLfloat m[16]);
  void glMultTransposeMatrixd(const GLdouble m[16]);
  void glMultTransposeMatrixf(const GLfloat m[16]);
  void glSampleCoverage(GLclampf value, GLboolean invert);
  void glSamplePass(GLenum pass);
]]

local bind = {}
local mod = {}


function mod.ClearIndex(c)
  bind.glClearIndex(c)
end

function mod.ClearColor(red, green, blue, alpha)
  bind.glClearColor(red, green, blue, alpha)
end

function mod.Clear(mask)
  bind.glClear(mask)
end

function mod.IndexMask(mask)
  bind.glIndexMask(mask)
end

function mod.ColorMask(red, green, blue, alpha)
  bind.glColorMask(red, green, blue, alpha)
end

function mod.AlphaFunc(func, ref)
  bind.glAlphaFunc(func, ref)
end

function mod.BlendFunc(sfactor, dfactor)
  bind.glBlendFunc(sfactor, dfactor)
end

function mod.LogicOp(opcode)
  bind.glLogicOp(opcode)
end

function mod.CullFace(mode)
  bind.glCullFace(mode)
end

function mod.FrontFace(mode)
  bind.glFrontFace(mode)
end

function mod.PointSize(size)
  bind.glPointSize(size)
end

function mod.LineWidth(width)
  bind.glLineWidth(width)
end

function mod.LineStipple(factor, pattern)
  bind.glLineStipple(factor, pattern)
end

function mod.PolygonMode(face, mode)
  bind.glPolygonMode(face, mode)
end

function mod.PolygonOffset(factor, units)
  bind.glPolygonOffset(factor, units)
end

function mod.PolygonStipple(mask)
--  void glPolygonStipple(const GLubyte *mask)
  bind.glPolygonStipple(mask)
end

function mod.GetPolygonStipple(mask)
--  void glGetPolygonStipple(GLubyte *mask)
  bind.glGetPolygonStipple(mask)
end

function mod.EdgeFlag(flag)
  bind.glEdgeFlag(flag)
end

function mod.EdgeFlagv(flag)
--  void glEdgeFlagv(const GLboolean *flag)
  bind.glEdgeFlagv(flag)
end

function mod.Scissor(x, y, width, height)
  bind.glScissor(x, y, width, height)
end

function mod.ClipPlane(plane, equation)
--  void glClipPlane(GLenum plane, const GLdouble *equation)
  bind.glClipPlane(plane, equation)
end

function mod.GetClipPlane(plane, equation)
--  void glGetClipPlane(GLenum plane, GLdouble *equation)
  bind.glGetClipPlane(plane, equation)
end

function mod.DrawBuffer(mode)
  bind.glDrawBuffer(mode)
end

function mod.ReadBuffer(mode)
  bind.glReadBuffer(mode)
end

function mod.Enable(cap)
  bind.glEnable(cap)
end

function mod.Disable(cap)
  bind.glDisable(cap)
end

function mod.IsEnabled(cap)
  return bind.glIsEnabled(cap)
end

function mod.EnableClientState(cap)
  bind.glEnableClientState(cap)
end

function mod.DisableClientState(cap)
  bind.glDisableClientState(cap)
end

function mod.GetBooleanv(pname, params)
--  void glGetBooleanv(GLenum pname, GLboolean *params)
  bind.glGetBooleanv(pname, params)
end

function mod.GetDoublev(pname, params)
--  void glGetDoublev(GLenum pname, GLdouble *params)
  bind.glGetDoublev(pname, params)
end

function mod.GetFloatv(pname, params)
--  void glGetFloatv(GLenum pname, GLfloat *params)
  bind.glGetFloatv(pname, params)
end

function mod.GetIntegerv(pname, params)
--  void glGetIntegerv(GLenum pname, GLint *params)
  bind.glGetIntegerv(pname, params)
end

function mod.PushAttrib(mask)
  bind.glPushAttrib(mask)
end

function mod.PopAttrib()
  bind.glPopAttrib()
end

function mod.PushClientAttrib(mask)
  bind.glPushClientAttrib(mask)
end

function mod.PopClientAttrib()
  bind.glPopClientAttrib()
end

function mod.RenderMode(mode)
  return bind.glRenderMode(mode)
end

function mod.GetError()
  return bind.glGetError()
end

function mod.GetString(name)
  return bind.glGetString(name)
end

function mod.Finish()
  bind.glFinish()
end

function mod.Flush()
  bind.glFlush()
end

function mod.Hint(target, mode)
  bind.glHint(target, mode)
end

function mod.ClearDepth(depth)
  bind.glClearDepth(depth)
end

function mod.DepthFunc(func)
  bind.glDepthFunc(func)
end

function mod.DepthMask(flag)
  bind.glDepthMask(flag)
end

function mod.DepthRange(near_val, far_val)
  bind.glDepthRange(near_val, far_val)
end

function mod.ClearAccum(red, green, blue, alpha)
  bind.glClearAccum(red, green, blue, alpha)
end

function mod.Accum(op, value)
  bind.glAccum(op, value)
end

function mod.MatrixMode(mode)
  bind.glMatrixMode(mode)
end

function mod.Ortho(left, right, bottom, top, near_val, far_val)
  bind.glOrtho(left, right, bottom, top, near_val, far_val)
end

function mod.Frustum(left, right, bottom, top, near_val, far_val)
  bind.glFrustum(left, right, bottom, top, near_val, far_val)
end

function mod.Viewport(x, y, width, height)
  bind.glViewport(x, y, width, height)
end

function mod.PushMatrix()
  bind.glPushMatrix()
end

function mod.PopMatrix()
  bind.glPopMatrix()
end

function mod.LoadIdentity()
  bind.glLoadIdentity()
end

function mod.LoadMatrixd(m)
--  void glLoadMatrixd(const GLdouble *m)
  bind.glLoadMatrixd(m)
end

function mod.LoadMatrixf(m)
--  void glLoadMatrixf(const GLfloat *m)
  bind.glLoadMatrixf(m)
end

function mod.MultMatrixd(m)
--  void glMultMatrixd(const GLdouble *m)
  bind.glMultMatrixd(m)
end

function mod.MultMatrixf(m)
--  void glMultMatrixf(const GLfloat *m)
  bind.glMultMatrixf(m)
end

function mod.Rotated(angle, x, y, z)
  bind.glRotated(angle, x, y, z)
end

function mod.Rotatef(angle, x, y, z)
  bind.glRotatef(angle, x, y, z)
end

function mod.Scaled(x, y, z)
  bind.glScaled(x, y, z)
end

function mod.Scalef(x, y, z)
  bind.glScalef(x, y, z)
end

function mod.Translated(x, y, z)
  bind.glTranslated(x, y, z)
end

function mod.Translatef(x, y, z)
  bind.glTranslatef(x, y, z)
end

function mod.IsList(list)
  return bind.glIsList(list)
end

function mod.DeleteLists(list, range)
  bind.glDeleteLists(list, range)
end

function mod.GenLists(range)
  return bind.glGenLists(range)
end

function mod.NewList(list, mode)
  bind.glNewList(list, mode)
end

function mod.EndList()
  bind.glEndList()
end

function mod.CallList(list)
  bind.glCallList(list)
end

function mod.CallLists(n, type, lists)
--  void glCallLists(GLsizei n, GLenum type, const GLvoid *lists)
  bind.glCallLists(n, type, lists)
end

function mod.ListBase(base)
  bind.glListBase(base)
end

function mod.Begin(mode)
  bind.glBegin(mode)
end

function mod.End()
  bind.glEnd()
end

function mod.Vertex2d(x, y)
  bind.glVertex2d(x, y)
end

function mod.Vertex2f(x, y)
  bind.glVertex2f(x, y)
end

function mod.Vertex2i(x, y)
  bind.glVertex2i(x, y)
end

function mod.Vertex2s(x, y)
  bind.glVertex2s(x, y)
end

function mod.Vertex3d(x, y, z)
  bind.glVertex3d(x, y, z)
end

function mod.Vertex3f(x, y, z)
  bind.glVertex3f(x, y, z)
end

function mod.Vertex3i(x, y, z)
  bind.glVertex3i(x, y, z)
end

function mod.Vertex3s(x, y, z)
  bind.glVertex3s(x, y, z)
end

function mod.Vertex4d(x, y, z, w)
  bind.glVertex4d(x, y, z, w)
end

function mod.Vertex4f(x, y, z, w)
  bind.glVertex4f(x, y, z, w)
end

function mod.Vertex4i(x, y, z, w)
  bind.glVertex4i(x, y, z, w)
end

function mod.Vertex4s(x, y, z, w)
  bind.glVertex4s(x, y, z, w)
end

function mod.Vertex2dv(v)
--  void glVertex2dv(const GLdouble *v)
  bind.glVertex2dv(v)
end

function mod.Vertex2fv(v)
--  void glVertex2fv(const GLfloat *v)
  bind.glVertex2fv(v)
end

function mod.Vertex2iv(v)
--  void glVertex2iv(const GLint *v)
  bind.glVertex2iv(v)
end

function mod.Vertex2sv(v)
--  void glVertex2sv(const GLshort *v)
  bind.glVertex2sv(v)
end

function mod.Vertex3dv(v)
--  void glVertex3dv(const GLdouble *v)
  bind.glVertex3dv(v)
end

function mod.Vertex3fv(v)
--  void glVertex3fv(const GLfloat *v)
  bind.glVertex3fv(v)
end

function mod.Vertex3iv(v)
--  void glVertex3iv(const GLint *v)
  bind.glVertex3iv(v)
end

function mod.Vertex3sv(v)
--  void glVertex3sv(const GLshort *v)
  bind.glVertex3sv(v)
end

function mod.Vertex4dv(v)
--  void glVertex4dv(const GLdouble *v)
  bind.glVertex4dv(v)
end

function mod.Vertex4fv(v)
--  void glVertex4fv(const GLfloat *v)
  bind.glVertex4fv(v)
end

function mod.Vertex4iv(v)
--  void glVertex4iv(const GLint *v)
  bind.glVertex4iv(v)
end

function mod.Vertex4sv(v)
--  void glVertex4sv(const GLshort *v)
  bind.glVertex4sv(v)
end

function mod.Normal3b(nx, ny, nz)
  bind.glNormal3b(nx, ny, nz)
end

function mod.Normal3d(nx, ny, nz)
  bind.glNormal3d(nx, ny, nz)
end

function mod.Normal3f(nx, ny, nz)
  bind.glNormal3f(nx, ny, nz)
end

function mod.Normal3i(nx, ny, nz)
  bind.glNormal3i(nx, ny, nz)
end

function mod.Normal3s(nx, ny, nz)
  bind.glNormal3s(nx, ny, nz)
end

function mod.Normal3bv(v)
--  void glNormal3bv(const GLbyte *v)
  bind.glNormal3bv(v)
end

function mod.Normal3dv(v)
--  void glNormal3dv(const GLdouble *v)
  bind.glNormal3dv(v)
end

function mod.Normal3fv(v)
--  void glNormal3fv(const GLfloat *v)
  bind.glNormal3fv(v)
end

function mod.Normal3iv(v)
--  void glNormal3iv(const GLint *v)
  bind.glNormal3iv(v)
end

function mod.Normal3sv(v)
--  void glNormal3sv(const GLshort *v)
  bind.glNormal3sv(v)
end

function mod.Indexd(c)
  bind.glIndexd(c)
end

function mod.Indexf(c)
  bind.glIndexf(c)
end

function mod.Indexi(c)
  bind.glIndexi(c)
end

function mod.Indexs(c)
  bind.glIndexs(c)
end

function mod.Indexub(c)
  bind.glIndexub(c)
end

function mod.Indexdv(c)
--  void glIndexdv(const GLdouble *c)
  bind.glIndexdv(c)
end

function mod.Indexfv(c)
--  void glIndexfv(const GLfloat *c)
  bind.glIndexfv(c)
end

function mod.Indexiv(c)
--  void glIndexiv(const GLint *c)
  bind.glIndexiv(c)
end

function mod.Indexsv(c)
--  void glIndexsv(const GLshort *c)
  bind.glIndexsv(c)
end

function mod.Indexubv(c)
--  void glIndexubv(const GLubyte *c)
  bind.glIndexubv(c)
end

function mod.Color3b(red, green, blue)
  bind.glColor3b(red, green, blue)
end

function mod.Color3d(red, green, blue)
  bind.glColor3d(red, green, blue)
end

function mod.Color3f(red, green, blue)
  bind.glColor3f(red, green, blue)
end

function mod.Color3i(red, green, blue)
  bind.glColor3i(red, green, blue)
end

function mod.Color3s(red, green, blue)
  bind.glColor3s(red, green, blue)
end

function mod.Color3ub(red, green, blue)
  bind.glColor3ub(red, green, blue)
end

function mod.Color3ui(red, green, blue)
  bind.glColor3ui(red, green, blue)
end

function mod.Color3us(red, green, blue)
  bind.glColor3us(red, green, blue)
end

function mod.Color4b(red, green, blue, alpha)
  bind.glColor4b(red, green, blue, alpha)
end

function mod.Color4d(red, green, blue, alpha)
  bind.glColor4d(red, green, blue, alpha)
end

function mod.Color4f(red, green, blue, alpha)
  bind.glColor4f(red, green, blue, alpha)
end

function mod.Color4i(red, green, blue, alpha)
  bind.glColor4i(red, green, blue, alpha)
end

function mod.Color4s(red, green, blue, alpha)
  bind.glColor4s(red, green, blue, alpha)
end

function mod.Color4ub(red, green, blue, alpha)
  bind.glColor4ub(red, green, blue, alpha)
end

function mod.Color4ui(red, green, blue, alpha)
  bind.glColor4ui(red, green, blue, alpha)
end

function mod.Color4us(red, green, blue, alpha)
  bind.glColor4us(red, green, blue, alpha)
end

function mod.Color3bv(v)
--  void glColor3bv(const GLbyte *v)
  bind.glColor3bv(v)
end

function mod.Color3dv(v)
--  void glColor3dv(const GLdouble *v)
  bind.glColor3dv(v)
end

function mod.Color3fv(v)
--  void glColor3fv(const GLfloat *v)
  bind.glColor3fv(v)
end

function mod.Color3iv(v)
--  void glColor3iv(const GLint *v)
  bind.glColor3iv(v)
end

function mod.Color3sv(v)
--  void glColor3sv(const GLshort *v)
  bind.glColor3sv(v)
end

function mod.Color3ubv(v)
--  void glColor3ubv(const GLubyte *v)
  bind.glColor3ubv(v)
end

function mod.Color3uiv(v)
--  void glColor3uiv(const GLuint *v)
  bind.glColor3uiv(v)
end

function mod.Color3usv(v)
--  void glColor3usv(const GLushort *v)
  bind.glColor3usv(v)
end

function mod.Color4bv(v)
--  void glColor4bv(const GLbyte *v)
  bind.glColor4bv(v)
end

function mod.Color4dv(v)
--  void glColor4dv(const GLdouble *v)
  bind.glColor4dv(v)
end

function mod.Color4fv(v)
--  void glColor4fv(const GLfloat *v)
  bind.glColor4fv(v)
end

function mod.Color4iv(v)
--  void glColor4iv(const GLint *v)
  bind.glColor4iv(v)
end

function mod.Color4sv(v)
--  void glColor4sv(const GLshort *v)
  bind.glColor4sv(v)
end

function mod.Color4ubv(v)
--  void glColor4ubv(const GLubyte *v)
  bind.glColor4ubv(v)
end

function mod.Color4uiv(v)
--  void glColor4uiv(const GLuint *v)
  bind.glColor4uiv(v)
end

function mod.Color4usv(v)
--  void glColor4usv(const GLushort *v)
  bind.glColor4usv(v)
end

function mod.TexCoord1d(s)
  bind.glTexCoord1d(s)
end

function mod.TexCoord1f(s)
  bind.glTexCoord1f(s)
end

function mod.TexCoord1i(s)
  bind.glTexCoord1i(s)
end

function mod.TexCoord1s(s)
  bind.glTexCoord1s(s)
end

function mod.TexCoord2d(s, t)
  bind.glTexCoord2d(s, t)
end

function mod.TexCoord2f(s, t)
  bind.glTexCoord2f(s, t)
end

function mod.TexCoord2i(s, t)
  bind.glTexCoord2i(s, t)
end

function mod.TexCoord2s(s, t)
  bind.glTexCoord2s(s, t)
end

function mod.TexCoord3d(s, t, r)
  bind.glTexCoord3d(s, t, r)
end

function mod.TexCoord3f(s, t, r)
  bind.glTexCoord3f(s, t, r)
end

function mod.TexCoord3i(s, t, r)
  bind.glTexCoord3i(s, t, r)
end

function mod.TexCoord3s(s, t, r)
  bind.glTexCoord3s(s, t, r)
end

function mod.TexCoord4d(s, t, r, q)
  bind.glTexCoord4d(s, t, r, q)
end

function mod.TexCoord4f(s, t, r, q)
  bind.glTexCoord4f(s, t, r, q)
end

function mod.TexCoord4i(s, t, r, q)
  bind.glTexCoord4i(s, t, r, q)
end

function mod.TexCoord4s(s, t, r, q)
  bind.glTexCoord4s(s, t, r, q)
end

function mod.TexCoord1dv(v)
--  void glTexCoord1dv(const GLdouble *v)
  bind.glTexCoord1dv(v)
end

function mod.TexCoord1fv(v)
--  void glTexCoord1fv(const GLfloat *v)
  bind.glTexCoord1fv(v)
end

function mod.TexCoord1iv(v)
--  void glTexCoord1iv(const GLint *v)
  bind.glTexCoord1iv(v)
end

function mod.TexCoord1sv(v)
--  void glTexCoord1sv(const GLshort *v)
  bind.glTexCoord1sv(v)
end

function mod.TexCoord2dv(v)
--  void glTexCoord2dv(const GLdouble *v)
  bind.glTexCoord2dv(v)
end

function mod.TexCoord2fv(v)
--  void glTexCoord2fv(const GLfloat *v)
  bind.glTexCoord2fv(v)
end

function mod.TexCoord2iv(v)
--  void glTexCoord2iv(const GLint *v)
  bind.glTexCoord2iv(v)
end

function mod.TexCoord2sv(v)
--  void glTexCoord2sv(const GLshort *v)
  bind.glTexCoord2sv(v)
end

function mod.TexCoord3dv(v)
--  void glTexCoord3dv(const GLdouble *v)
  bind.glTexCoord3dv(v)
end

function mod.TexCoord3fv(v)
--  void glTexCoord3fv(const GLfloat *v)
  bind.glTexCoord3fv(v)
end

function mod.TexCoord3iv(v)
--  void glTexCoord3iv(const GLint *v)
  bind.glTexCoord3iv(v)
end

function mod.TexCoord3sv(v)
--  void glTexCoord3sv(const GLshort *v)
  bind.glTexCoord3sv(v)
end

function mod.TexCoord4dv(v)
--  void glTexCoord4dv(const GLdouble *v)
  bind.glTexCoord4dv(v)
end

function mod.TexCoord4fv(v)
--  void glTexCoord4fv(const GLfloat *v)
  bind.glTexCoord4fv(v)
end

function mod.TexCoord4iv(v)
--  void glTexCoord4iv(const GLint *v)
  bind.glTexCoord4iv(v)
end

function mod.TexCoord4sv(v)
--  void glTexCoord4sv(const GLshort *v)
  bind.glTexCoord4sv(v)
end

function mod.RasterPos2d(x, y)
  bind.glRasterPos2d(x, y)
end

function mod.RasterPos2f(x, y)
  bind.glRasterPos2f(x, y)
end

function mod.RasterPos2i(x, y)
  bind.glRasterPos2i(x, y)
end

function mod.RasterPos2s(x, y)
  bind.glRasterPos2s(x, y)
end

function mod.RasterPos3d(x, y, z)
  bind.glRasterPos3d(x, y, z)
end

function mod.RasterPos3f(x, y, z)
  bind.glRasterPos3f(x, y, z)
end

function mod.RasterPos3i(x, y, z)
  bind.glRasterPos3i(x, y, z)
end

function mod.RasterPos3s(x, y, z)
  bind.glRasterPos3s(x, y, z)
end

function mod.RasterPos4d(x, y, z, w)
  bind.glRasterPos4d(x, y, z, w)
end

function mod.RasterPos4f(x, y, z, w)
  bind.glRasterPos4f(x, y, z, w)
end

function mod.RasterPos4i(x, y, z, w)
  bind.glRasterPos4i(x, y, z, w)
end

function mod.RasterPos4s(x, y, z, w)
  bind.glRasterPos4s(x, y, z, w)
end

function mod.RasterPos2dv(v)
--  void glRasterPos2dv(const GLdouble *v)
  bind.glRasterPos2dv(v)
end

function mod.RasterPos2fv(v)
--  void glRasterPos2fv(const GLfloat *v)
  bind.glRasterPos2fv(v)
end

function mod.RasterPos2iv(v)
--  void glRasterPos2iv(const GLint *v)
  bind.glRasterPos2iv(v)
end

function mod.RasterPos2sv(v)
--  void glRasterPos2sv(const GLshort *v)
  bind.glRasterPos2sv(v)
end

function mod.RasterPos3dv(v)
--  void glRasterPos3dv(const GLdouble *v)
  bind.glRasterPos3dv(v)
end

function mod.RasterPos3fv(v)
--  void glRasterPos3fv(const GLfloat *v)
  bind.glRasterPos3fv(v)
end

function mod.RasterPos3iv(v)
--  void glRasterPos3iv(const GLint *v)
  bind.glRasterPos3iv(v)
end

function mod.RasterPos3sv(v)
--  void glRasterPos3sv(const GLshort *v)
  bind.glRasterPos3sv(v)
end

function mod.RasterPos4dv(v)
--  void glRasterPos4dv(const GLdouble *v)
  bind.glRasterPos4dv(v)
end

function mod.RasterPos4fv(v)
--  void glRasterPos4fv(const GLfloat *v)
  bind.glRasterPos4fv(v)
end

function mod.RasterPos4iv(v)
--  void glRasterPos4iv(const GLint *v)
  bind.glRasterPos4iv(v)
end

function mod.RasterPos4sv(v)
--  void glRasterPos4sv(const GLshort *v)
  bind.glRasterPos4sv(v)
end

function mod.Rectd(x1, y1, x2, y2)
  bind.glRectd(x1, y1, x2, y2)
end

function mod.Rectf(x1, y1, x2, y2)
  bind.glRectf(x1, y1, x2, y2)
end

function mod.Recti(x1, y1, x2, y2)
  bind.glRecti(x1, y1, x2, y2)
end

function mod.Rects(x1, y1, x2, y2)
  bind.glRects(x1, y1, x2, y2)
end

function mod.Rectdv(v1, v2)
--  void glRectdv(const GLdouble *v1, const GLdouble *v2)
  bind.glRectdv(v1, v2)
end

function mod.Rectfv(v1, v2)
--  void glRectfv(const GLfloat *v1, const GLfloat *v2)
  bind.glRectfv(v1, v2)
end

function mod.Rectiv(v1, v2)
--  void glRectiv(const GLint *v1, const GLint *v2)
  bind.glRectiv(v1, v2)
end

function mod.Rectsv(v1, v2)
--  void glRectsv(const GLshort *v1, const GLshort *v2)
  bind.glRectsv(v1, v2)
end

function mod.ShadeModel(mode)
  bind.glShadeModel(mode)
end

function mod.Lightf(light, pname, param)
  bind.glLightf(light, pname, param)
end

function mod.Lighti(light, pname, param)
  bind.glLighti(light, pname, param)
end

function mod.Lightfv(light, pname, params)
--  void glLightfv(GLenum light, GLenum pname, const GLfloat *params)
  bind.glLightfv(light, pname, params)
end

function mod.Lightiv(light, pname, params)
--  void glLightiv(GLenum light, GLenum pname, const GLint *params)
  bind.glLightiv(light, pname, params)
end

function mod.GetLightfv(light, pname, params)
--  void glGetLightfv(GLenum light, GLenum pname, GLfloat *params)
  bind.glGetLightfv(light, pname, params)
end

function mod.GetLightiv(light, pname, params)
--  void glGetLightiv(GLenum light, GLenum pname, GLint *params)
  bind.glGetLightiv(light, pname, params)
end

function mod.LightModelf(pname, param)
  bind.glLightModelf(pname, param)
end

function mod.LightModeli(pname, param)
  bind.glLightModeli(pname, param)
end

function mod.LightModelfv(pname, params)
--  void glLightModelfv(GLenum pname, const GLfloat *params)
  bind.glLightModelfv(pname, params)
end

function mod.LightModeliv(pname, params)
--  void glLightModeliv(GLenum pname, const GLint *params)
  bind.glLightModeliv(pname, params)
end

function mod.Materialf(face, pname, param)
  bind.glMaterialf(face, pname, param)
end

function mod.Materiali(face, pname, param)
  bind.glMateriali(face, pname, param)
end

function mod.Materialfv(face, pname, params)
--  void glMaterialfv(GLenum face, GLenum pname, const GLfloat *params)
  bind.glMaterialfv(face, pname, params)
end

function mod.Materialiv(face, pname, params)
--  void glMaterialiv(GLenum face, GLenum pname, const GLint *params)
  bind.glMaterialiv(face, pname, params)
end

function mod.GetMaterialfv(face, pname, params)
--  void glGetMaterialfv(GLenum face, GLenum pname, GLfloat *params)
  bind.glGetMaterialfv(face, pname, params)
end

function mod.GetMaterialiv(face, pname, params)
--  void glGetMaterialiv(GLenum face, GLenum pname, GLint *params)
  bind.glGetMaterialiv(face, pname, params)
end

function mod.ColorMaterial(face, mode)
  bind.glColorMaterial(face, mode)
end

function mod.PixelZoom(xfactor, yfactor)
  bind.glPixelZoom(xfactor, yfactor)
end

function mod.PixelStoref(pname, param)
  bind.glPixelStoref(pname, param)
end

function mod.PixelStorei(pname, param)
  bind.glPixelStorei(pname, param)
end

function mod.PixelTransferf(pname, param)
  bind.glPixelTransferf(pname, param)
end

function mod.PixelTransferi(pname, param)
  bind.glPixelTransferi(pname, param)
end

function mod.PixelMapfv(map, mapsize, values)
--  void glPixelMapfv(GLenum map, GLint mapsize, const GLfloat *values)
  bind.glPixelMapfv(map, mapsize, values)
end

function mod.PixelMapuiv(map, mapsize, values)
--  void glPixelMapuiv(GLenum map, GLint mapsize, const GLuint *values)
  bind.glPixelMapuiv(map, mapsize, values)
end

function mod.PixelMapusv(map, mapsize, values)
--  void glPixelMapusv(GLenum map, GLint mapsize, const GLushort *values)
  bind.glPixelMapusv(map, mapsize, values)
end

function mod.GetPixelMapfv(map, values)
--  void glGetPixelMapfv(GLenum map, GLfloat *values)
  bind.glGetPixelMapfv(map, values)
end

function mod.GetPixelMapuiv(map, values)
--  void glGetPixelMapuiv(GLenum map, GLuint *values)
  bind.glGetPixelMapuiv(map, values)
end

function mod.GetPixelMapusv(map, values)
--  void glGetPixelMapusv(GLenum map, GLushort *values)
  bind.glGetPixelMapusv(map, values)
end

function mod.Bitmap(width, height, xorig, yorig, xmove, ymove, bitmap)
--  void glBitmap(GLsizei width, GLsizei height, GLfloat xorig, GLfloat yorig, GLfloat xmove, GLfloat ymove, const GLubyte *bitmap)
  bind.glBitmap(width, height, xorig, yorig, xmove, ymove, bitmap)
end

function mod.ReadPixels(x, y, width, height, format, type, pixels)
--  void glReadPixels(GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid *pixels)
  bind.glReadPixels(x, y, width, height, format, type, pixels)
end

function mod.DrawPixels(width, height, format, type, pixels)
--  void glDrawPixels(GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels)
  bind.glDrawPixels(width, height, format, type, pixels)
end

function mod.CopyPixels(x, y, width, height, type)
  bind.glCopyPixels(x, y, width, height, type)
end

function mod.StencilFunc(func, ref, mask)
  bind.glStencilFunc(func, ref, mask)
end

function mod.StencilMask(mask)
  bind.glStencilMask(mask)
end

function mod.StencilOp(fail, zfail, zpass)
  bind.glStencilOp(fail, zfail, zpass)
end

function mod.ClearStencil(s)
  bind.glClearStencil(s)
end

function mod.TexGend(coord, pname, param)
  bind.glTexGend(coord, pname, param)
end

function mod.TexGenf(coord, pname, param)
  bind.glTexGenf(coord, pname, param)
end

function mod.TexGeni(coord, pname, param)
  bind.glTexGeni(coord, pname, param)
end

function mod.TexGendv(coord, pname, params)
--  void glTexGendv(GLenum coord, GLenum pname, const GLdouble *params)
  bind.glTexGendv(coord, pname, params)
end

function mod.TexGenfv(coord, pname, params)
--  void glTexGenfv(GLenum coord, GLenum pname, const GLfloat *params)
  bind.glTexGenfv(coord, pname, params)
end

function mod.TexGeniv(coord, pname, params)
--  void glTexGeniv(GLenum coord, GLenum pname, const GLint *params)
  bind.glTexGeniv(coord, pname, params)
end

function mod.GetTexGendv(coord, pname, params)
--  void glGetTexGendv(GLenum coord, GLenum pname, GLdouble *params)
  bind.glGetTexGendv(coord, pname, params)
end

function mod.GetTexGenfv(coord, pname, params)
--  void glGetTexGenfv(GLenum coord, GLenum pname, GLfloat *params)
  bind.glGetTexGenfv(coord, pname, params)
end

function mod.GetTexGeniv(coord, pname, params)
--  void glGetTexGeniv(GLenum coord, GLenum pname, GLint *params)
  bind.glGetTexGeniv(coord, pname, params)
end

function mod.TexEnvf(target, pname, param)
  bind.glTexEnvf(target, pname, param)
end

function mod.TexEnvi(target, pname, param)
  bind.glTexEnvi(target, pname, param)
end

function mod.TexEnvfv(target, pname, params)
--  void glTexEnvfv(GLenum target, GLenum pname, const GLfloat *params)
  bind.glTexEnvfv(target, pname, params)
end

function mod.TexEnviv(target, pname, params)
--  void glTexEnviv(GLenum target, GLenum pname, const GLint *params)
  bind.glTexEnviv(target, pname, params)
end

function mod.GetTexEnvfv(target, pname, params)
--  void glGetTexEnvfv(GLenum target, GLenum pname, GLfloat *params)
  bind.glGetTexEnvfv(target, pname, params)
end

function mod.GetTexEnviv(target, pname, params)
--  void glGetTexEnviv(GLenum target, GLenum pname, GLint *params)
  bind.glGetTexEnviv(target, pname, params)
end

function mod.TexParameterf(target, pname, param)
  bind.glTexParameterf(target, pname, param)
end

function mod.TexParameteri(target, pname, param)
  bind.glTexParameteri(target, pname, param)
end

function mod.TexParameterfv(target, pname, params)
--  void glTexParameterfv(GLenum target, GLenum pname, const GLfloat *params)
  bind.glTexParameterfv(target, pname, params)
end

function mod.TexParameteriv(target, pname, params)
--  void glTexParameteriv(GLenum target, GLenum pname, const GLint *params)
  bind.glTexParameteriv(target, pname, params)
end

function mod.GetTexParameterfv(target, pname, params)
--  void glGetTexParameterfv(GLenum target, GLenum pname, GLfloat *params)
  bind.glGetTexParameterfv(target, pname, params)
end

function mod.GetTexParameteriv(target, pname, params)
--  void glGetTexParameteriv(GLenum target, GLenum pname, GLint *params)
  bind.glGetTexParameteriv(target, pname, params)
end

function mod.GetTexLevelParameterfv(target, level, pname, params)
--  void glGetTexLevelParameterfv(GLenum target, GLint level, GLenum pname, GLfloat *params)
  bind.glGetTexLevelParameterfv(target, level, pname, params)
end

function mod.GetTexLevelParameteriv(target, level, pname, params)
--  void glGetTexLevelParameteriv(GLenum target, GLint level, GLenum pname, GLint *params)
  bind.glGetTexLevelParameteriv(target, level, pname, params)
end

function mod.TexImage1D(target, level, internal_format, width, border, format, type, pixels)
--  void glTexImage1D(GLenum target, GLint level, GLint internalFormat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid *pixels)
  bind.glTexImage1D(target, level, internal_format, width, border, format, type, pixels)
end

function mod.TexImage2D(target, level, internal_format, width, height, border, format, type, pixels)
--  void glTexImage2D(GLenum target, GLint level, GLint internalFormat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels)
  bind.glTexImage2D(target, level, internal_format, width, height, border, format, type, pixels)
end

function mod.GetTexImage(target, level, format, type, pixels)
--  void glGetTexImage(GLenum target, GLint level, GLenum format, GLenum type, GLvoid *pixels)
  bind.glGetTexImage(target, level, format, type, pixels)
end

function mod.Map1d(target, u1, u2, stride, order, points)
--  void glMap1d(GLenum target, GLdouble u1, GLdouble u2, GLint stride, GLint order, const GLdouble *points)
  bind.glMap1d(target, u1, u2, stride, order, points)
end

function mod.Map1f(target, u1, u2, stride, order, points)
--  void glMap1f(GLenum target, GLfloat u1, GLfloat u2, GLint stride, GLint order, const GLfloat *points)
  bind.glMap1f(target, u1, u2, stride, order, points)
end

function mod.Map2d(target, u1, u2, ustride, uorder, v1, v2, vstride, vorder, points)
--  void glMap2d(GLenum target, GLdouble u1, GLdouble u2, GLint ustride, GLint uorder, GLdouble v1, GLdouble v2, GLint vstride, GLint vorder, const GLdouble *points)
  bind.glMap2d(target, u1, u2, ustride, uorder, v1, v2, vstride, vorder, points)
end

function mod.Map2f(target, u1, u2, ustride, uorder, v1, v2, vstride, vorder, points)
--  void glMap2f(GLenum target, GLfloat u1, GLfloat u2, GLint ustride, GLint uorder, GLfloat v1, GLfloat v2, GLint vstride, GLint vorder, const GLfloat *points)
  bind.glMap2f(target, u1, u2, ustride, uorder, v1, v2, vstride, vorder, points)
end

function mod.GetMapdv(target, query, v)
--  void glGetMapdv(GLenum target, GLenum query, GLdouble *v)
  bind.glGetMapdv(target, query, v)
end

function mod.GetMapfv(target, query, v)
--  void glGetMapfv(GLenum target, GLenum query, GLfloat *v)
  bind.glGetMapfv(target, query, v)
end

function mod.GetMapiv(target, query, v)
--  void glGetMapiv(GLenum target, GLenum query, GLint *v)
  bind.glGetMapiv(target, query, v)
end

function mod.EvalCoord1d(u)
  bind.glEvalCoord1d(u)
end

function mod.EvalCoord1f(u)
  bind.glEvalCoord1f(u)
end

function mod.EvalCoord1dv(u)
--  void glEvalCoord1dv(const GLdouble *u)
  bind.glEvalCoord1dv(u)
end

function mod.EvalCoord1fv(u)
--  void glEvalCoord1fv(const GLfloat *u)
  bind.glEvalCoord1fv(u)
end

function mod.EvalCoord2d(u, v)
  bind.glEvalCoord2d(u, v)
end

function mod.EvalCoord2f(u, v)
  bind.glEvalCoord2f(u, v)
end

function mod.EvalCoord2dv(u)
--  void glEvalCoord2dv(const GLdouble *u)
  bind.glEvalCoord2dv(u)
end

function mod.EvalCoord2fv(u)
--  void glEvalCoord2fv(const GLfloat *u)
  bind.glEvalCoord2fv(u)
end

function mod.MapGrid1d(un, u1, u2)
  bind.glMapGrid1d(un, u1, u2)
end

function mod.MapGrid1f(un, u1, u2)
  bind.glMapGrid1f(un, u1, u2)
end

function mod.MapGrid2d(un, u1, u2, vn, v1, v2)
  bind.glMapGrid2d(un, u1, u2, vn, v1, v2)
end

function mod.MapGrid2f(un, u1, u2, vn, v1, v2)
  bind.glMapGrid2f(un, u1, u2, vn, v1, v2)
end

function mod.EvalPoint1(i)
  bind.glEvalPoint1(i)
end

function mod.EvalPoint2(i, j)
  bind.glEvalPoint2(i, j)
end

function mod.EvalMesh1(mode, i1, i2)
  bind.glEvalMesh1(mode, i1, i2)
end

function mod.EvalMesh2(mode, i1, i2, j1, j2)
  bind.glEvalMesh2(mode, i1, i2, j1, j2)
end

function mod.Fogf(pname, param)
  bind.glFogf(pname, param)
end

function mod.Fogi(pname, param)
  bind.glFogi(pname, param)
end

function mod.Fogfv(pname, params)
--  void glFogfv(GLenum pname, const GLfloat *params)
  bind.glFogfv(pname, params)
end

function mod.Fogiv(pname, params)
--  void glFogiv(GLenum pname, const GLint *params)
  bind.glFogiv(pname, params)
end

function mod.FeedbackBuffer(size, type, buffer)
--  void glFeedbackBuffer(GLsizei size, GLenum type, GLfloat *buffer)
  bind.glFeedbackBuffer(size, type, buffer)
end

function mod.PassThrough(token)
  bind.glPassThrough(token)
end

function mod.SelectBuffer(size, buffer)
--  void glSelectBuffer(GLsizei size, GLuint *buffer)
  bind.glSelectBuffer(size, buffer)
end

function mod.InitNames()
  bind.glInitNames()
end

function mod.LoadName(name)
  bind.glLoadName(name)
end

function mod.PushName(name)
  bind.glPushName(name)
end

function mod.PopName()
  bind.glPopName()
end

function mod.GenTextures(n, textures)
--  void glGenTextures(GLsizei n, GLuint *textures)
  bind.glGenTextures(n, textures)
end

function mod.DeleteTextures(n, textures)
--  void glDeleteTextures(GLsizei n, const GLuint *textures)
  bind.glDeleteTextures(n, textures)
end

function mod.BindTexture(target, texture)
  bind.glBindTexture(target, texture)
end

function mod.PrioritizeTextures(n, textures, priorities)
--  void glPrioritizeTextures(GLsizei n, const GLuint *textures, const GLclampf *priorities)
  bind.glPrioritizeTextures(n, textures, priorities)
end

function mod.AreTexturesResident(n, textures, residences)
--  GLboolean glAreTexturesResident(GLsizei n, const GLuint *textures, GLboolean *residences)
  return bind.glAreTexturesResident(n, textures, residences)
end

function mod.IsTexture(texture)
  return bind.glIsTexture(texture)
end

function mod.TexSubImage1D(target, level, xoffset, width, format, type, pixels)
--  void glTexSubImage1D(GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const GLvoid *pixels)
  bind.glTexSubImage1D(target, level, xoffset, width, format, type, pixels)
end

function mod.TexSubImage2D(target, level, xoffset, yoffset, width, height, format, type, pixels)
--  void glTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels)
  bind.glTexSubImage2D(target, level, xoffset, yoffset, width, height, format, type, pixels)
end

function mod.CopyTexImage1D(target, level, internalformat, x, y, width, border)
  bind.glCopyTexImage1D(target, level, internalformat, x, y, width, border)
end

function mod.CopyTexImage2D(target, level, internalformat, x, y, width, height, border)
  bind.glCopyTexImage2D(target, level, internalformat, x, y, width, height, border)
end

function mod.CopyTexSubImage1D(target, level, xoffset, x, y, width)
  bind.glCopyTexSubImage1D(target, level, xoffset, x, y, width)
end

function mod.CopyTexSubImage2D(target, level, xoffset, yoffset, x, y, width, height)
  bind.glCopyTexSubImage2D(target, level, xoffset, yoffset, x, y, width, height)
end

function mod.VertexPointer(size, type, stride, ptr)
--  void glVertexPointer(GLint size, GLenum type, GLsizei stride, const GLvoid *ptr)
  bind.glVertexPointer(size, type, stride, ptr)
end

function mod.NormalPointer(type, stride, ptr)
--  void glNormalPointer(GLenum type, GLsizei stride, const GLvoid *ptr)
  bind.glNormalPointer(type, stride, ptr)
end

function mod.ColorPointer(size, type, stride, ptr)
--  void glColorPointer(GLint size, GLenum type, GLsizei stride, const GLvoid *ptr)
  bind.glColorPointer(size, type, stride, ptr)
end

function mod.IndexPointer(type, stride, ptr)
--  void glIndexPointer(GLenum type, GLsizei stride, const GLvoid *ptr)
  bind.glIndexPointer(type, stride, ptr)
end

function mod.TexCoordPointer(size, type, stride, ptr)
--  void glTexCoordPointer(GLint size, GLenum type, GLsizei stride, const GLvoid *ptr)
  bind.glTexCoordPointer(size, type, stride, ptr)
end

function mod.EdgeFlagPointer(stride, ptr)
--  void glEdgeFlagPointer(GLsizei stride, const GLvoid *ptr)
  bind.glEdgeFlagPointer(stride, ptr)
end

function mod.GetPointerv(pname, params)
--  void glGetPointerv(GLenum pname, GLvoid **params)
  bind.glGetPointerv(pname, params)
end

function mod.ArrayElement(i)
  bind.glArrayElement(i)
end

function mod.DrawArrays(mode, first, count)
  bind.glDrawArrays(mode, first, count)
end

function mod.DrawElements(mode, count, type, indices)
--  void glDrawElements(GLenum mode, GLsizei count, GLenum type, const GLvoid *indices)
  bind.glDrawElements(mode, count, type, indices)
end

function mod.InterleavedArrays(format, stride, pointer)
--  void glInterleavedArrays(GLenum format, GLsizei stride, const GLvoid *pointer)
  bind.glInterleavedArrays(format, stride, pointer)
end

function mod.DrawRangeElements(mode, start, _end, count, type, indices)
--  void glDrawRangeElements(GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices)
  bind.glDrawRangeElements(mode, start, _end, count, type, indices)
end

function mod.TexImage3D(target, level, internal_format, width, height, depth, border, format, type, pixels)
--  void glTexImage3D(GLenum target, GLint level, GLenum internalFormat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid *pixels)
  bind.glTexImage3D(target, level, internal_format, width, height, depth, border, format, type, pixels)
end

function mod.TexSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, type, pixels)
--  void glTexSubImage3D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const GLvoid *pixels)
  bind.glTexSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, type, pixels)
end

function mod.CopyTexSubImage3D(target, level, xoffset, yoffset, zoffset, x, y, width, height)
  bind.glCopyTexSubImage3D(target, level, xoffset, yoffset, zoffset, x, y, width, height)
end

function mod.ColorTable(target, internalformat, width, format, type, table)
--  void glColorTable(GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const GLvoid *table)
  bind.glColorTable(target, internalformat, width, format, type, table)
end

function mod.ColorSubTable(target, start, count, format, type, data)
--  void glColorSubTable(GLenum target, GLsizei start, GLsizei count, GLenum format, GLenum type, const GLvoid *data)
  bind.glColorSubTable(target, start, count, format, type, data)
end

function mod.ColorTableParameteriv(target, pname, params)
--  void glColorTableParameteriv(GLenum target, GLenum pname, const GLint *params)
  bind.glColorTableParameteriv(target, pname, params)
end

function mod.ColorTableParameterfv(target, pname, params)
--  void glColorTableParameterfv(GLenum target, GLenum pname, const GLfloat *params)
  bind.glColorTableParameterfv(target, pname, params)
end

function mod.CopyColorSubTable(target, start, x, y, width)
  bind.glCopyColorSubTable(target, start, x, y, width)
end

function mod.CopyColorTable(target, internalformat, x, y, width)
  bind.glCopyColorTable(target, internalformat, x, y, width)
end

function mod.GetColorTable(target, format, type, table)
--  void glGetColorTable(GLenum target, GLenum format, GLenum type, GLvoid *table)
  bind.glGetColorTable(target, format, type, table)
end

function mod.GetColorTableParameterfv(target, pname, params)
--  void glGetColorTableParameterfv(GLenum target, GLenum pname, GLfloat *params)
  bind.glGetColorTableParameterfv(target, pname, params)
end

function mod.GetColorTableParameteriv(target, pname, params)
--  void glGetColorTableParameteriv(GLenum target, GLenum pname, GLint *params)
  bind.glGetColorTableParameteriv(target, pname, params)
end

function mod.BlendEquation(mode)
  bind.glBlendEquation(mode)
end

function mod.BlendColor(red, green, blue, alpha)
  bind.glBlendColor(red, green, blue, alpha)
end

function mod.Histogram(target, width, internalformat, sink)
  bind.glHistogram(target, width, internalformat, sink)
end

function mod.ResetHistogram(target)
  bind.glResetHistogram(target)
end

function mod.GetHistogram(target, reset, format, type, values)
--  void glGetHistogram(GLenum target, GLboolean reset, GLenum format, GLenum type, GLvoid *values)
  bind.glGetHistogram(target, reset, format, type, values)
end

function mod.GetHistogramParameterfv(target, pname, params)
--  void glGetHistogramParameterfv(GLenum target, GLenum pname, GLfloat *params)
  bind.glGetHistogramParameterfv(target, pname, params)
end

function mod.GetHistogramParameteriv(target, pname, params)
--  void glGetHistogramParameteriv(GLenum target, GLenum pname, GLint *params)
  bind.glGetHistogramParameteriv(target, pname, params)
end

function mod.Minmax(target, internalformat, sink)
  bind.glMinmax(target, internalformat, sink)
end

function mod.ResetMinmax(target)
  bind.glResetMinmax(target)
end

function mod.GetMinmax(target, reset, format, types, values)
--  void glGetMinmax(GLenum target, GLboolean reset, GLenum format, GLenum types, GLvoid *values)
  bind.glGetMinmax(target, reset, format, types, values)
end

function mod.GetMinmaxParameterfv(target, pname, params)
--  void glGetMinmaxParameterfv(GLenum target, GLenum pname, GLfloat *params)
  bind.glGetMinmaxParameterfv(target, pname, params)
end

function mod.GetMinmaxParameteriv(target, pname, params)
--  void glGetMinmaxParameteriv(GLenum target, GLenum pname, GLint *params)
  bind.glGetMinmaxParameteriv(target, pname, params)
end

function mod.ConvolutionFilter1D(target, internalformat, width, format, type, image)
--  void glConvolutionFilter1D(GLenum target, GLenum internalformat, GLsizei width, GLenum format, GLenum type, const GLvoid *image)
  bind.glConvolutionFilter1D(target, internalformat, width, format, type, image)
end

function mod.ConvolutionFilter2D(target, internalformat, width, height, format, type, image)
--  void glConvolutionFilter2D(GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *image)
  bind.glConvolutionFilter2D(target, internalformat, width, height, format, type, image)
end

function mod.ConvolutionParameterf(target, pname, params)
  bind.glConvolutionParameterf(target, pname, params)
end

function mod.ConvolutionParameterfv(target, pname, params)
--  void glConvolutionParameterfv(GLenum target, GLenum pname, const GLfloat *params)
  bind.glConvolutionParameterfv(target, pname, params)
end

function mod.ConvolutionParameteri(target, pname, params)
  bind.glConvolutionParameteri(target, pname, params)
end

function mod.ConvolutionParameteriv(target, pname, params)
--  void glConvolutionParameteriv(GLenum target, GLenum pname, const GLint *params)
  bind.glConvolutionParameteriv(target, pname, params)
end

function mod.CopyConvolutionFilter1D(target, internalformat, x, y, width)
  bind.glCopyConvolutionFilter1D(target, internalformat, x, y, width)
end

function mod.CopyConvolutionFilter2D(target, internalformat, x, y, width, height)
  bind.glCopyConvolutionFilter2D(target, internalformat, x, y, width, height)
end

function mod.GetConvolutionFilter(target, format, type, image)
--  void glGetConvolutionFilter(GLenum target, GLenum format, GLenum type, GLvoid *image)
  bind.glGetConvolutionFilter(target, format, type, image)
end

function mod.GetConvolutionParameterfv(target, pname, params)
--  void glGetConvolutionParameterfv(GLenum target, GLenum pname, GLfloat *params)
  bind.glGetConvolutionParameterfv(target, pname, params)
end

function mod.GetConvolutionParameteriv(target, pname, params)
--  void glGetConvolutionParameteriv(GLenum target, GLenum pname, GLint *params)
  bind.glGetConvolutionParameteriv(target, pname, params)
end

function mod.SeparableFilter2D(target, internalformat, width, height, format, type, row, column)
--  void glSeparableFilter2D(GLenum target, GLenum internalformat, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *row, const GLvoid *column)
  bind.glSeparableFilter2D(target, internalformat, width, height, format, type, row, column)
end

function mod.GetSeparableFilter(target, format, type, row, column, span)
--  void glGetSeparableFilter(GLenum target, GLenum format, GLenum type, GLvoid *row, GLvoid *column, GLvoid *span)
  bind.glGetSeparableFilter(target, format, type, row, column, span)
end

function mod.ActiveTexture(texture)
  bind.glActiveTexture(texture)
end

function mod.ClientActiveTexture(texture)
  bind.glClientActiveTexture(texture)
end

function mod.CompressedTexImage1D(target, level, internalformat, width, border, image_size, data)
--  void glCompressedTexImage1D(GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const GLvoid *data)
  bind.glCompressedTexImage1D(target, level, internalformat, width, border, image_size, data)
end

function mod.CompressedTexImage2D(target, level, internalformat, width, height, border, image_size, data)
--  void glCompressedTexImage2D(GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid *data)
  bind.glCompressedTexImage2D(target, level, internalformat, width, height, border, image_size, data)
end

function mod.CompressedTexImage3D(target, level, internalformat, width, height, depth, border, image_size, data)
--  void glCompressedTexImage3D(GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const GLvoid *data)
  bind.glCompressedTexImage3D(target, level, internalformat, width, height, depth, border, image_size, data)
end

function mod.CompressedTexSubImage1D(target, level, xoffset, width, format, image_size, data)
--  void glCompressedTexSubImage1D(GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const GLvoid *data)
  bind.glCompressedTexSubImage1D(target, level, xoffset, width, format, image_size, data)
end

function mod.CompressedTexSubImage2D(target, level, xoffset, yoffset, width, height, format, image_size, data)
--  void glCompressedTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid *data)
  bind.glCompressedTexSubImage2D(target, level, xoffset, yoffset, width, height, format, image_size, data)
end

function mod.CompressedTexSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, image_size, data)
--  void glCompressedTexSubImage3D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const GLvoid *data)
  bind.glCompressedTexSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, image_size, data)
end

function mod.GetCompressedTexImage(target, lod, img)
--  void glGetCompressedTexImage(GLenum target, GLint lod, GLvoid *img)
  bind.glGetCompressedTexImage(target, lod, img)
end

function mod.MultiTexCoord1d(target, s)
  bind.glMultiTexCoord1d(target, s)
end

function mod.MultiTexCoord1dv(target, v)
--  void glMultiTexCoord1dv(GLenum target, const GLdouble *v)
  bind.glMultiTexCoord1dv(target, v)
end

function mod.MultiTexCoord1f(target, s)
  bind.glMultiTexCoord1f(target, s)
end

function mod.MultiTexCoord1fv(target, v)
--  void glMultiTexCoord1fv(GLenum target, const GLfloat *v)
  bind.glMultiTexCoord1fv(target, v)
end

function mod.MultiTexCoord1i(target, s)
  bind.glMultiTexCoord1i(target, s)
end

function mod.MultiTexCoord1iv(target, v)
--  void glMultiTexCoord1iv(GLenum target, const GLint *v)
  bind.glMultiTexCoord1iv(target, v)
end

function mod.MultiTexCoord1s(target, s)
  bind.glMultiTexCoord1s(target, s)
end

function mod.MultiTexCoord1sv(target, v)
--  void glMultiTexCoord1sv(GLenum target, const GLshort *v)
  bind.glMultiTexCoord1sv(target, v)
end

function mod.MultiTexCoord2d(target, s, t)
  bind.glMultiTexCoord2d(target, s, t)
end

function mod.MultiTexCoord2dv(target, v)
--  void glMultiTexCoord2dv(GLenum target, const GLdouble *v)
  bind.glMultiTexCoord2dv(target, v)
end

function mod.MultiTexCoord2f(target, s, t)
  bind.glMultiTexCoord2f(target, s, t)
end

function mod.MultiTexCoord2fv(target, v)
--  void glMultiTexCoord2fv(GLenum target, const GLfloat *v)
  bind.glMultiTexCoord2fv(target, v)
end

function mod.MultiTexCoord2i(target, s, t)
  bind.glMultiTexCoord2i(target, s, t)
end

function mod.MultiTexCoord2iv(target, v)
--  void glMultiTexCoord2iv(GLenum target, const GLint *v)
  bind.glMultiTexCoord2iv(target, v)
end

function mod.MultiTexCoord2s(target, s, t)
  bind.glMultiTexCoord2s(target, s, t)
end

function mod.MultiTexCoord2sv(target, v)
--  void glMultiTexCoord2sv(GLenum target, const GLshort *v)
  bind.glMultiTexCoord2sv(target, v)
end

function mod.MultiTexCoord3d(target, s, t, r)
  bind.glMultiTexCoord3d(target, s, t, r)
end

function mod.MultiTexCoord3dv(target, v)
--  void glMultiTexCoord3dv(GLenum target, const GLdouble *v)
  bind.glMultiTexCoord3dv(target, v)
end

function mod.MultiTexCoord3f(target, s, t, r)
  bind.glMultiTexCoord3f(target, s, t, r)
end

function mod.MultiTexCoord3fv(target, v)
--  void glMultiTexCoord3fv(GLenum target, const GLfloat *v)
  bind.glMultiTexCoord3fv(target, v)
end

function mod.MultiTexCoord3i(target, s, t, r)
  bind.glMultiTexCoord3i(target, s, t, r)
end

function mod.MultiTexCoord3iv(target, v)
--  void glMultiTexCoord3iv(GLenum target, const GLint *v)
  bind.glMultiTexCoord3iv(target, v)
end

function mod.MultiTexCoord3s(target, s, t, r)
  bind.glMultiTexCoord3s(target, s, t, r)
end

function mod.MultiTexCoord3sv(target, v)
--  void glMultiTexCoord3sv(GLenum target, const GLshort *v)
  bind.glMultiTexCoord3sv(target, v)
end

function mod.MultiTexCoord4d(target, s, t, r, q)
  bind.glMultiTexCoord4d(target, s, t, r, q)
end

function mod.MultiTexCoord4dv(target, v)
--  void glMultiTexCoord4dv(GLenum target, const GLdouble *v)
  bind.glMultiTexCoord4dv(target, v)
end

function mod.MultiTexCoord4f(target, s, t, r, q)
  bind.glMultiTexCoord4f(target, s, t, r, q)
end

function mod.MultiTexCoord4fv(target, v)
--  void glMultiTexCoord4fv(GLenum target, const GLfloat *v)
  bind.glMultiTexCoord4fv(target, v)
end

function mod.MultiTexCoord4i(target, s, t, r, q)
  bind.glMultiTexCoord4i(target, s, t, r, q)
end

function mod.MultiTexCoord4iv(target, v)
--  void glMultiTexCoord4iv(GLenum target, const GLint *v)
  bind.glMultiTexCoord4iv(target, v)
end

function mod.MultiTexCoord4s(target, s, t, r, q)
  bind.glMultiTexCoord4s(target, s, t, r, q)
end

function mod.MultiTexCoord4sv(target, v)
--  void glMultiTexCoord4sv(GLenum target, const GLshort *v)
  bind.glMultiTexCoord4sv(target, v)
end

function mod.LoadTransposeMatrixd(m)
--  void glLoadTransposeMatrixd(const GLdouble m[16])
  bind.glLoadTransposeMatrixd(m)
end

function mod.LoadTransposeMatrixf(m)
--  void glLoadTransposeMatrixf(const GLfloat m[16])
  bind.glLoadTransposeMatrixf(m)
end

function mod.MultTransposeMatrixd(m)
--  void glMultTransposeMatrixd(const GLdouble m[16])
  bind.glMultTransposeMatrixd(m)
end

function mod.MultTransposeMatrixf(m)
--  void glMultTransposeMatrixf(const GLfloat m[16])
  bind.glMultTransposeMatrixf(m)
end

function mod.SampleCoverage(value, invert)
  bind.glSampleCoverage(value, invert)
end

function mod.SamplePass(pass)
  bind.glSamplePass(pass)
end


mod.const = const
mod.__raw = bind

setmetatable(mod, {
  __call = function(self, name)
    ffi.cdef(header)

    bind = ffi.load(name)

    return self
  end
})

return mod
