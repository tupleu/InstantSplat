#! /bin/bash

GPU_ID=0
DATA_ROOT_DIR="C:/Users/asus/Documents/GitHub/InstantSplat/data"
DATASETS=(
    # TT
    # sora
    # mars
    # trees
    room
    )

SCENES=(
    # Family
    # Barn
    # Francis
    # Horse
    # Ignatius
    # santorini
    # tree1
    room0
    room1
    room2
    room3
    room4
    room5
    room6
    room7
    room8
    room9
    room10
    room11
    room12
    room13
    room14
    room15
    room16
    room17
    room18
    room19
    room20
    room21
    room22
    room23
    room24
    room25
    room26
    room27
    room28
    room29
    room30
    room31
    room32
    room33
    room34
    room35
    room36
    room37
    room38
    room39
    room40
    room41
    room42
    room43
    room44
    room45
    room46
    room47
    room48
    room49
    room50
    room51
    room52
    room53
    room54
    room55
    room56
    room57
    room58
    room59
    room60
    room61
    room62
    room63
    room64
    room65
    room66
    room67
    room68
    room69
    room70
    room71
    room72
    room73
    room74
    room75
    room76
    room77
    room78
    room79
    room80
    room81
    room82
    room83
    room84
    room85
    room86
    room87
    room88
    room89
    room90
    room91
    room92
    room93
    room94
    room95
    room96
    room97
    room98
    room99
    room100
    room101
    room102
    room103
    room104
    room105
    room106
    room107
    room108
    room109
    room110
    room111
    room112
    room113
    room114
    room115
    room116
    room117
    room118
    room119
    room120
    room121
    room122
    room123
    room124
    room125
    room126
    room127
    room128
    room129
    room130
    room131
    room132
    room133
    room134
    room135
    room136
    room137
    room138
    room139
    room140
    room141
    room142
    room143
    room144
    room145
    room146
    room147
    room148
    room149
    room150
    room151
    room152
    room153
    room154
    room155
    room156
    room157
    room158
    room159
    room160
    room161
    room162
    room163
    room164
    room165
    room166
    room167
    room168
    room169
    room170
    room171
    room172
    room173
    room174
    room175
    room176
    room177
    room178
    room179
    room180
    room181
    room182
    room183
    room184
    room185
    room186
    room187
    room188
    room189
    room190
    room191
    room192
    room193
    room194
    room195
    room196
    room197
    room198
    room199
    room200
    room201
    room202
    room203
    room204
    room205
    room206
    room207
    room208
    room209
    room210
    room211
    room212
    room213
    room214
    room215
    room216
    room217
    room218
    room219
    room220
    room221
    room222
    room223
    room224
    room225
    room226
    room227
    room228
    room229
    room230
    room231
    room232
    room233
    room234
    room235
    room236
    room237
    room238
    room239
    room240
    room241
    room242
    room243
    room244
    room245
    room246
    room247
    room248
    room249
    room250
    room251
    room252
    room253
    room254
    room255
    room256
    room257
    room258
    room259
    room260
    room261
    room262
    room263
    room264
    room265
    room266
    room267
    room268
    room269
    room270
    room271
    room272
    room273
    room274
    room275
    room276
    room277
    room278
    room279
    room280
    room281
    room282
    room283
    room284
    room285
    room286
    room287
    room288
    room289
    room290
    room291
    room292
    room293
    room294
    )

N_VIEWS=(
    2
    # 3
    # 5
    # 9
    # 12
    # 15
    # 18
    )

# increase iteration to get better metrics (e.g. gs_train_iter=5000)
gs_train_iter=1000
pose_lr=1x

for DATASET in "${DATASETS[@]}"; do
    for SCENE in "${SCENES[@]}"; do
        for N_VIEW in "${N_VIEWS[@]}"; do

            # SOURCE_PATH must be Absolute path
            SOURCE_PATH=${DATA_ROOT_DIR}/${DATASET}/${SCENE}/${N_VIEW}_views
            MODEL_PATH=./output/infer/${DATASET}/${SCENE}/${N_VIEW}_views_${gs_train_iter}Iter_${pose_lr}PoseLR/

            # # ----- (1) Dust3r_coarse_geometric_initialization -----
            CMD_D1="CUDA_VISIBLE_DEVICES=${GPU_ID} python -W ignore ./coarse_init_infer.py \
            --img_base_path ${SOURCE_PATH} \
            --n_views ${N_VIEW}  \
            --focal_avg \
            "

            # # ----- (2) Train: jointly optimize pose -----
            CMD_T="CUDA_VISIBLE_DEVICES=${GPU_ID} python -W ignore ./train_joint2.py \
            -s ${SOURCE_PATH} \
            -m ${MODEL_PATH}  \
            --n_views ${N_VIEW}  \
            --scene ${SCENE} \
            --iter ${gs_train_iter} \
            --optim_pose \
            "

            # ----- (3) Render interpolated pose & output video -----
            CMD_RI="CUDA_VISIBLE_DEVICES=${GPU_ID} python -W ignore ./render_pose.py \
            -s ${SOURCE_PATH} \
            -m ${MODEL_PATH}  \
            --n_views ${N_VIEW}  \
            --scene ${SCENE} \
            --iter ${gs_train_iter} \
            --eval \
            --get_video \
            "


            echo "========= ${SCENE}: Dust3r_coarse_geometric_initialization ========="
            eval $CMD_D1
            echo "========= ${SCENE}: Train: jointly optimize pose ========="
            eval $CMD_T
            echo "========= ${SCENE}: Render interpolated pose & output video ========="
            eval $CMD_RI
            done
        done
    done