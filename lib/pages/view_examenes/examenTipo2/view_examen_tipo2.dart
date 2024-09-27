// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mycar/api/api_laboratorio.dart';
import 'package:mycar/functions/examenes.dart';
import 'package:mycar/models/examen-model.dart';
import 'package:mycar/models/examen_tipo2_model.dart';
import 'package:mycar/models/paciente.dart';
import 'package:mycar/widgets/modals/floating_modal.dart';
import 'package:mycar/widgets/modals/modal_fit.dart';
import 'package:mycar/widgets/text_field.dart';

class ViewExamenTipo2 extends StatefulWidget {
  final ExamenTipo2 examen;
  final Paciente paciente;
  final String fecha;
  final String codexamen;
  final List<CodExamen> exameneswi;
  const ViewExamenTipo2({
    super.key,
    required this.examen,
    required this.paciente,
    required this.fecha,
    required this.codexamen,
    required this.exameneswi,
  });

  @override
  State<ViewExamenTipo2> createState() => _ViewExamenTipo2State();
}

class _ViewExamenTipo2State extends State<ViewExamenTipo2> {
  bool guardando_ = false;
  ExamenTipo2 examenS = ExamenTipo2();
  late TextEditingController valoracionController;
  late TextEditingController observacionesController;

  @override
  void initState() {
    super.initState();
    if (widget.examen.valoracion != null) {
      valoracionController =
          TextEditingController(text: widget.examen.valoracion!);
    }
    if (widget.examen.observaciones != null) {
      observacionesController =
          TextEditingController(text: widget.examen.observaciones!);
    }
    examenS = widget.examen;
  }

  @override
  Widget build(BuildContext context) {
    String nexamen = widget.examen.nombreExamen!;
    /*  nexamen = nexamen.length > 25
        ? (widget.examen.nombreExamen!).substring(0, 25)
        : nexamen; */
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        foregroundColor: Colors.black,
        title: const Text(
          'Registro de Exámenes',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        actions: [
          /*  IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WebViewLab()),
              );
            },
            icon: const Icon(Icons.web),
          ), */
          Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarTipo2(context, examenS, widget.codexamen).then(
                        (value) {
                          if (true) {
                            printPDFFile(
                              context,
                              "examen_tipo_2",
                              widget.examen.nombreExamen!,
                              "${widget.examen.nombreExamen!}_${widget.paciente.identificacion}_${widget.fecha}.pdf",
                              widget.paciente.identificacion!,
                              widget.fecha,
                              widget.paciente.nombreCompleto,
                              widget.paciente.edad,
                            );
                          }
                          setState(() => guardando_ = !guardando_);
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.print,
                      color: Colors.brown,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: 13,
                      height: 13,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: !guardando_
                ? IconButton(
                    onPressed: () async {
                      setState(() => guardando_ = !guardando_);
                      guardarTipo2(context, examenS, widget.codexamen).then(
                        (value) {
                          showFloatingModalBottomSheet(
                            context: context,
                            builder: (context) => ModalFit(
                              title:
                                  '${examenS.nombreExamen!} almacenada con éxito',
                              asset: 'images/lab.png',
                            ),
                          );
                          setState(() => guardando_ = !guardando_);
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.blueGrey,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: 13,
                      height: 13,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('images/lab.png'),
                ),
                const SizedBox(width: 2),
                Container(
                  constraints: const BoxConstraints(
                      maxWidth: 250), // Define una altura máxima
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nexamen,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.paciente.nombreCompleto,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.fecha,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blueGrey,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Form(
            onChanged: () {
              examenS.valoracion = valoracionController.text;
              examenS.observaciones = observacionesController.text;
              examenS.identificacion = widget.paciente.identificacion;
              examenS.fecha = widget.fecha;
              print({"valoracionF": valoracionController.text});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 0.76 * MediaQuery.of(context).size.width,
                        child: TextFieldI(
                          labelText: 'Valoración',
                          controller: valoracionController,
                          dropdown: examenesWithItems(
                              widget.codexamen, widget.exameneswi),
                          codexamen: widget.codexamen,
                          campo: 'Valoracion',
                        ),
                      ),
                      SizedBox(
                        width: 0.1 * MediaQuery.of(context).size.width,
                        child: widget.examen.unidades!.isNotEmpty
                            ? Text(widget.examen.unidades!)
                            : const Text(''),
                      ),
                      SizedBox(
                        width: 0.1 * MediaQuery.of(context).size.width,
                        child: widget.examen.constant!.isNotEmpty
                            ? Text('Normal: ${widget.examen.constant!}')
                            : const Text(''),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 0.95 * MediaQuery.of(context).size.width,
                    child: TextFieldI(
                        labelText: 'Observaciones',
                        controller: observacionesController),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
