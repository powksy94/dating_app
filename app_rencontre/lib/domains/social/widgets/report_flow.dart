import 'package:flutter/material.dart';
import 'package:nocturne/domains/social/services/user_action_service.dart';
import 'package:nocturne/domains/social/widgets/report_reason_tree.dart';
import 'package:nocturne/domains/social/widgets/report_flow/report_flow_root_view.dart';
import 'package:nocturne/domains/social/widgets/report_flow/report_flow_subs_view.dart';
import 'package:nocturne/domains/social/widgets/report_flow/report_flow_text_field_view.dart';
import 'package:nocturne/domains/social/widgets/report_flow/report_flow_done_view.dart';

/// Reports an account, optionally from a specific chat message (the message
/// is passed through as evidence — see user_action_service.dart). Each step
/// is its own widget (see widgets/report_flow/); this orchestrator only
/// tracks which step is showing and submits the final reason.
void showReportFlow(
  BuildContext context, {
  required String userId,
  required String username,
  String? messageId,
  String? messageSnapshot,
  VoidCallback? onReported,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A0A1F),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => _ReportFlow(
      userId: userId,
      username: username,
      messageId: messageId,
      messageSnapshot: messageSnapshot,
      onReported: onReported,
    ),
  );
}

class _ReportFlow extends StatefulWidget {
  final String userId;
  final String username;
  final String? messageId;
  final String? messageSnapshot;
  final VoidCallback? onReported;
  const _ReportFlow({
    required this.userId,
    required this.username,
    this.messageId,
    this.messageSnapshot,
    this.onReported,
  });

  @override
  State<_ReportFlow> createState() => _ReportFlowState();
}

class _ReportFlowState extends State<_ReportFlow> {
  ReportCategory? _selected;
  final _textCtrl = TextEditingController();
  bool _sending   = false;
  bool _done      = false;

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit(String reason) async {
    setState(() => _sending = true);
    final success = await UserActionService.reportUser(widget.userId, reason, messageId: widget.messageId);
    if (success) widget.onReported?.call();
    if (mounted) setState(() { _sending = false; _done = true; });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        // The keyboard opening/closing (autofocus on the "Other" text field)
        // animates viewInsets.bottom, which can transiently leave less room
        // than the content's natural height — scrollable instead of a bare
        // Column so that moment never overflows instead of showing one.
        child: SingleChildScrollView(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _buildStep(),
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    if (_done) return const ReportFlowDoneView();
    if (_selected == null) {
      return ReportFlowRootView(
        username: widget.username,
        messageSnapshot: widget.messageSnapshot,
        sending: _sending,
        onSelect: (cat) => cat.isLeaf ? _submit(cat.label) : setState(() => _selected = cat),
      );
    }
    if (_selected!.hasSubs) {
      return ReportFlowSubsView(
        category: _selected!,
        sending: _sending,
        onBack: () => setState(() => _selected = null),
        onSelect: (sub) => _submit('${_selected!.label} — $sub'),
      );
    }
    return ReportFlowTextFieldView(
      categoryLabel: _selected!.label,
      controller: _textCtrl,
      sending: _sending,
      onBack: () => setState(() => _selected = null),
      onSubmit: () {
        final t = _textCtrl.text.trim();
        if (t.isEmpty) return;
        _submit('Autre — $t');
      },
    );
  }
}
