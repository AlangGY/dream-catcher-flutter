# 💤 DreamCatcher

## 프로젝트 개요

DreamCatcher는 사용자의 꿈을 기록하고 분석하여 자기 이해와 감정 관리에 도움을 주는 AI 기반 알람 앱입니다. 사용자가 잠에서 깨어난 직후 꿈을 기록하도록 유도하며, AI 챗봇과의 인터랙션을 통해 꿈에 대한 자세한 내용을 기록할 수 있습니다.

[📑 프로젝트 기획안 보기](PROJECT_PROPOSAL.md)

## 주요 기능

- 스마트 알람: 설정한 시간에 알람이 울리고 꿈 기록을 위한 인터페이스로 연결
- AI 꿈 인터뷰: 대화형 인터페이스를 통해 사용자의 꿈 내용을 질문하고 기록
- 꿈 일기 저장 및 열람: 날짜별로 꿈 기록을 저장하고 분류하여 열람 가능
- 꿈 분석: AI를 통한 꿈 내용 분석 및 통계 제공

## 기술 스택

- **프론트엔드**: Flutter
- **상태 관리**: Provider/Bloc
- **디자인 시스템**: Material Design 3
- **최소 iOS 버전**: iOS 15.0

## 개발 환경 설정

### 요구 사항

- Flutter SDK 3.0 이상
- Dart 3.0 이상
- iOS 15.0 이상 (iOS 빌드용)
- Android 5.0 (API 레벨 21) 이상

### 설치 및 실행

1. 레포지토리 클론

```bash
git clone https://github.com/yourusername/dream_catcher.git
cd dream_catcher
```

2. 의존성 설치

```bash
flutter pub get
```

3. 앱 실행

```bash
flutter run
```

## 작업 진행 상황

- [x] 프로젝트 기본 구조 설정
- [x] 기본 UI 컴포넌트 구현 (AppLogo, KakaoLoginButton 등)
- [x] 네비게이션 시스템 구현 (NavigationWrapper, CommonBottomNavBar)
- [x] 기본 화면 UI 구현:
  - [x] 랜딩 화면
  - [x] 홈 화면
  - [x] 프로필 화면
  - [x] 꿈 목록 화면
  - [x] 꿈 상세 화면
  - [x] 꿈 분석 화면
  - [x] 꿈 알람 화면
  - [x] 꿈 인터뷰 화면
  - [x] 실시간 챗 화면
- [ ] 카카오 로그인 기능 구현
- [ ] AI 인터뷰 기능 구현 (UI는 준비됨)
- [ ] 꿈 일기 저장 및 관리 기능 연동
- [ ] 알람 설정 및 트리거 기능 연동
- [ ] 데이터 분석 기능 연동
