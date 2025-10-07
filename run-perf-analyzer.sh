docker run --rm -it \
    --net=host nvcr.io/nvidia/tritonserver:24.12-py3-sdk \
    bash -c "perf_analyzer -m particlenet_AK4_PT -i grpc -u localhost:8801 \
    --async -p 1 -b 100 --concurrency-range 1 \
    --shape pf_points__0:2,100 --shape pf_features__1:20,100 --shape pf_mask__2:1,100 --shape sv_points__3:2,10 --shape sv_features__4:11,10 --shape sv_mask__5:1,10 \
    --request-count=10000"
