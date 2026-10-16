# 시뮬레이션 안내

## Vivado Simulator

Vivado Tcl에서 저장소의 `scripts/create_sim_project.tcl`을 실행하면 Basys3 FPGA 부품 설정의 시뮬레이션 프로젝트를 `build/vivado/`에 구성합니다.

```tcl
source scripts/create_sim_project.tcl
```

또는 저장소 루트에서:

```sh
vivado -mode batch -source scripts/create_sim_project.tcl
```

프로젝트 생성 후 Vivado GUI에서 Behavioral Simulation을 실행합니다. top은 `tb_rv32i`이며 설계 top은 `top_rv32i_soc`입니다. `define.vh` include 경로와 두 `.mem` 파일을 함께 제공합니다. 실제 ROM은 `instruction_code.mem`을 읽습니다.

## 확인할 사항

- 원본 테스트벤치는 `always #5`이므로 timescale 기준 10ns 주기입니다.
- 원본은 20개의 negedge 대기 후 `$stop`합니다. 이 설정만으로 프로그램 전체 결과가 자동 보장되지는 않습니다.
- 합산 프로그램의 a0=55 결과는 기존 프로젝트 설명이며 이 정리에서 다시 실행해 확인한 결과가 아닙니다.
- 사용 중인 시뮬레이터가 메모리 파일을 찾지 못하면 실행 디렉터리에 `instruction_code.mem`이 복사되었는지 확인합니다.

스크립트는 소스 경로를 기준으로 새로 구성했으며 Vivado에서의 실행 검증은 하지 않았습니다. RTL 동작 로직은 수정하지 않았습니다.
