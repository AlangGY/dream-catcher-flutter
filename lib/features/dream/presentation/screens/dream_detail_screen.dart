import 'package:dream_catcher/shared/common-ui/ui_export.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DreamDetailScreen extends StatefulWidget {
  const DreamDetailScreen({Key? key}) : super(key: key);

  @override
  State<DreamDetailScreen> createState() => _DreamDetailScreenState();
}

class _DreamDetailScreenState extends State<DreamDetailScreen> {
  // 임시 데이터
  final Map<String, dynamic> dreamData = {
    'title': '바다에서 수영하는 꿈',
    'date': '2023년 5월 15일',
    'mood': '평화로움',
    'color': const Color(0xFF6699CC),
    'content':
        '오늘 꿈에서 넓고 푸른 바다에서 수영을 하고 있었다. 물은 따뜻하고 햇빛은 적당히 비추고 있었다. 물 속에서는 다양한 물고기들이 나와 함께 수영을 하며 즐겁게 놀았다. 특히 무지개 빛깔의 물고기가 계속 내 주변을 맴돌았는데, 그 물고기와 대화를 나누는 느낌이었다. 그 물고기가 나에게 앞으로의 일에 대해 이야기를 해주는 것 같았지만 구체적인 내용은 기억나지 않는다. 바다 깊은 곳까지 들어갔지만 숨이 막히지 않고 자유롭게 호흡할 수 있었다.',
    'tags': ['바다', '수영', '물고기', '평화', '자유'],
    'people': ['없음'],
    'clearness': 4,
    'lucidity': 2,
    'symbolism': '자유, 평화, 새로운 시작',
    'interpretation':
        '바다는 내면의 감정과 무의식을 상징한다고 하는데, 푸른 바다에서 자유롭게 수영하는 꿈은 현재 내 마음이 평화롭고 안정되어 있음을 의미하는 것 같다. 물고기와의 소통은 내 무의식과 대화를 나누는 것으로 해석할 수 있을 것 같다.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2FF),
      appBar: CommonAppBar(
        title: '',
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
            onPressed: () {
              // 꿈 편집 화면으로 이동
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline,
                color: Theme.of(context).primaryColor),
            onPressed: () {
              // 꿈 삭제 다이얼로그 표시
              _showDeleteDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildContent(),
            const SizedBox(height: 24),
            _buildTagSection(),
            const SizedBox(height: 24),
            _buildDetailSection(),
            const SizedBox(height: 24),
            _buildInterpretationSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 24,
              decoration: BoxDecoration(
                color: dreamData['color'] as Color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                dreamData['title'] as String,
                style: AppTextStyles.heading1(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 14,
                color: dreamData['color'] as Color,
              ),
              const SizedBox(width: 6),
              Text(
                dreamData['date'] as String,
                style: AppTextStyles.caption,
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.emoji_emotions_outlined,
                size: 14,
                color: dreamData['color'] as Color,
              ),
              const SizedBox(width: 6),
              Text(
                dreamData['mood'] as String,
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return CommonCard(
      padding: const EdgeInsets.all(20),
      child: Text(
        dreamData['content'] as String,
        style: AppTextStyles.body,
      ),
    );
  }

  Widget _buildTagSection() {
    final tags = dreamData['tags'] as List<String>;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: '태그',
          padding: const EdgeInsets.only(bottom: 12),
        ),
        TagsWrap(
          tags: tags,
          tagColor: dreamData['color'] as Color,
        ),
      ],
    );
  }

  Widget _buildDetailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: '세부 정보',
          padding: const EdgeInsets.only(bottom: 16),
        ),
        CommonCard(
          child: Column(
            children: [
              _buildDetailItem(
                  '등장인물', _formatList(dreamData['people'] as List<String>)),
              const Divider(),
              _buildDetailItem('선명도', '${dreamData['clearness']}/5'),
              const Divider(),
              _buildDetailItem('자각몽 여부', '${dreamData['lucidity']}/5'),
              const Divider(),
              _buildDetailItem('상징', dreamData['symbolism']),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyEmphasis(context),
          ),
          Text(
            value,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }

  Widget _buildInterpretationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: '해석',
          padding: const EdgeInsets.only(bottom: 16),
        ),
        CommonCard(
          child: Text(
            dreamData['interpretation'] as String,
            style: AppTextStyles.body,
          ),
        ),
      ],
    );
  }

  String _formatList(List<String> items) {
    if (items.isEmpty) return '없음';
    return items.join(', ');
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('꿈 기록 삭제', style: AppTextStyles.heading2(context)),
        content: Text(
          '이 꿈 기록을 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('취소', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              // 삭제 로직 처리
              context.pop();
              context.pop();
            },
            child: Text('삭제', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
