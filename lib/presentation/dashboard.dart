import 'package:flutter/material.dart';
import 'package:jezt_internship_app/models/dash_board_response.dart';
import 'package:jezt_internship_app/presentation/login.dart';
import 'package:jezt_internship_app/services/services.dart';

class ScreenDashboard extends StatefulWidget {
  final String access;

  const ScreenDashboard({super.key, required this.access});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  bool _loading = true;
  bool _error = false;
  String? _errorMessage;
  DashBoardResponse? _data;

  @override
  void initState() {
    super.initState();
    _fetchDashboard();
  }

  Future<void> _fetchDashboard() async {
    setState(() {
      _loading = true;
      _error = false;
      _errorMessage = null;
    });

    try {
      final dashboardData = await Services.fetchDashboardData(widget.access);

      if (dashboardData.detail != null) {
        setState(() {
          _loading = false;
          _error = true;
          _errorMessage = dashboardData.detail;
        });
      } else {
        setState(() {
          _data = dashboardData;
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _error = true;
        _errorMessage = 'Failed to fetch data.';
      });
    }
  }

  void _navigate() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => ScreenLogin()));
  }

  void _showMessage(String message, {Color color = Colors.red}) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  void _logout() async {
    final message = await Services.logout(widget.access);

    if (message != null) {
      _showMessage(message);
      _navigate();
      return;
    }
    _showMessage("Logged out successfully", color: Colors.green);
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Dashboard", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_errorMessage ?? 'An error occurred.'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _fetchDashboard,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : _buildDashboardContent(),
    );
  }

  Widget _buildDashboardContent() {
    final data = _data!;
    final items = [
      {"title": "Company Name", "value": data.companyName},
      {"title": "Employee Count", "value": data.employeeCount?.toString()},
      {"title": "Camera Count", "value": data.cameraCount?.toString()},
      {"title": "Attendance %", "value": "${data.attendancePercentage}%"},
      {
        "title": "Last Date Attendance %",
        "value": "${data.lastDateAttendancePercentage}%",
      },
      {
        "title": "Today's Total Images",
        "value": data.todaysTotalImgs?.toString(),
      },
      {"title": "Today's Format Total", "value": data.todaysFormatTotal},
      {"title": "Total Images Processed", "value": data.totalImagesProcessed},
      {"title": "Today's Date", "value": data.todayDate},
      {"title": "PP Enabled", "value": data.pp == true ? "Yes" : "No"},
      {
        "title": "Last 5 Attendance %",
        "value": data.last5AttendancePercentages!.isEmpty
            ? "[]"
            : data.last5AttendancePercentages?.join(", "),
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildCard(index, item["title"]!, item["value"]);
      },
    );
  }

  Widget _buildCard(int index, String title, String? value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          child: Text('${index + 1}'),
        ),
        title: Text(title),
        subtitle: Text(value ?? "N/A"),
      ),
    );
  }
}
