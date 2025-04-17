import 'package:flutter/material.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF6666CC)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF6666CC)),
            onPressed: () {
              // 꿈 편집 화면으로 이동
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFF6666CC)),
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
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4D4D99),
                ),
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
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8080B2),
                ),
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
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8080B2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        dreamData['content'] as String,
        style: const TextStyle(
          fontSize: 16,
          height: 1.6,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildTagSection() {
    final tags = dreamData['tags'] as List<String>;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '태그',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: dreamData['color'].withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '#$tag',
                style: TextStyle(
                  fontSize: 14,
                  color: dreamData['color'] as Color,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDetailSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailItem('등장인물', (dreamData['people'] as List).join(', ')),
          const Divider(height: 24),
          _buildDetailItem('선명도', '${dreamData['clearness']}/5'),
          const Divider(height: 24),
          _buildDetailItem('명료함', '${dreamData['lucidity']}/5'),
          const Divider(height: 24),
          _buildDetailItem('상징', dreamData['symbolism'] as String),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF8080B2),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4D4D99),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInterpretationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '해몽',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4D4D99),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF6666CC).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF6666CC).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6666CC).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      size: 16,
                      color: Color(0xFF6666CC),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'AI 해몽',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6666CC),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                dreamData['interpretation'] as String,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Color(0xFF4D4D99),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            '꿈 기록 삭제',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4D4D99),
            ),
          ),
          content: const Text(
            '정말로 이 꿈 기록을 삭제하시겠습니까? 삭제된 기록은 복구할 수 없습니다.',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                '취소',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF8080B2),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // 삭제 로직 구현
                Navigator.pop(context); // 다이얼로그 닫기
                Navigator.pop(context); // 상세 화면 닫기
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '삭제',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
