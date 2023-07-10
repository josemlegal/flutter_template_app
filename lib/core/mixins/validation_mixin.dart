import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

const EMPTY_EMAIL = "Debes ingresar un correo electronico";
const EMPTY_PASSWORD = "Debes ingresar una contraseña";
const EMPTY_NAME = "Debes ingresar un nombre";
const EMPTY_LASTNAME = "Debes ingresar un nombre y apellido";
const INVALID_NAME = "Debes ingresar un nombre valido";
const INVALID_LASTNAME = "Debes ingresar un apellido valido";
const EMPTY_SEX = "Debes ingresar un sexo";
const EMPTY_WEIGHT = "Debes ingresar un peso";
const INVALID_WEIGHT = "Debes ingresar un peso valido";
const EMPTY_HEIGHT = "Debes ingresar una altura";
const INVALID_HEIGHT = "Ingresa una altura valida";
const EMPTY_GOAL = "Ingresa una meta principal";
const EMPTY_ACTIVITY = "Ingresa tu nivel de actividad";
const EMPTY_EXERCISE = "Ingresa tu nivel de ejercicio";
const EMPTY_DOB = "Debes elegir una fecha de nacimiento";
const INVALID_FOOD_QUANTITY = "Ingresa una cantidad de gramos validos";
const EMPTY_TRAINING_STATUS = "Debes ingresar tu nivel de entrenamiento";
const EMPTY_FOOD_SUGGESTION_NAME = "Debes ingresar el nombre de la sugerencia";
const EMPTY_FOOD_SUGGESTION_TYPE = "Debes elegir un tipo de sugerencia";
const INVALID_DOB = "La fecha no es valida";
const PASSWORDS_DONT_MATCH = 'Las contraseñas deben ser iguales';
const EMPTY_PASSWORD_CONFIRMATION = 'Debes confirmar tu contraseña';
const INVALID_PORTION_SIZE = "Ingresa una porción valida";
const INVALID_NUTRITIONAL_VALUE = "Ingresa un numero valido";

mixin Validation {
  bool validateFoodQuanity(String quantity) {
    if (int.tryParse(quantity) == null) {
      return false;
    }
    return true;
  }

  String validateNutritionValue(String quantity) {
    if (isEmptyOrNull(quantity) || double.tryParse(quantity) == null) {
      return INVALID_NUTRITIONAL_VALUE;
    }
    return '';
  }

  String validatePortionSize(String portionSize) {
    if (int.tryParse(portionSize) == null) return INVALID_PORTION_SIZE;
    if (int.parse(portionSize) == 0) return INVALID_PORTION_SIZE;
    return '';
  }

  String validateFoodSuggestionName(String text) {
    if (isEmptyOrNull(text)) return EMPTY_FOOD_SUGGESTION_NAME;
    return "";
  }

  String validateFoodSuggestionType(String? text) {
    if (isEmptyOrNull(text)) return EMPTY_FOOD_SUGGESTION_TYPE;
    return "";
  }

  String validateName(String text) {
    if (isEmptyOrNull(text)) {
      return EMPTY_NAME;
    }

    if (text.trim().split(" ").length < 2) {
      return EMPTY_LASTNAME;
    }

    if (text.trim().split(" ")[0].length < 3) {
      return INVALID_NAME;
    }

    if (text.trim().split(" ")[1].length < 3) {
      return INVALID_LASTNAME;
    }

    return "";
  }

  String validateTrainingStatus(String? trainingStatus) {
    if (isEmptyOrNull(trainingStatus)) {
      return EMPTY_TRAINING_STATUS;
    }
    return '';
  }

  String validateSex(String sex) {
    if (isEmptyOrNull(sex)) {
      return EMPTY_SEX;
    }

    return "";
  }

  String validateWeight(String weightString) {
    if (isEmptyOrNull(weightString) || double.tryParse(weightString) == null) {
      return EMPTY_WEIGHT;
    }

    if (double.parse(weightString) < 30 || double.parse(weightString) > 250) {
      return INVALID_WEIGHT;
    }

    return "";
  }

  String validateHeight(String heightString) {
    if (isEmptyOrNull(heightString) || int.tryParse(heightString) == null) {
      return EMPTY_HEIGHT;
    }

    if (int.parse(heightString) < 100 || int.parse(heightString) > 220) {
      return INVALID_HEIGHT;
    }

    return "";
  }

  String validateGoal(String mainGoalString) {
    if (isEmptyOrNull(mainGoalString)) {
      return EMPTY_GOAL;
    }

    return "";
  }

  String validateActivityLevel(String activityLevelString) {
    if (isEmptyOrNull(activityLevelString)) {
      return EMPTY_ACTIVITY;
    }

    return "";
  }

  String validateDOB(DateTime? dob) {
    if (dob == null) return EMPTY_DOB;
    return '';
  }

  String validateDate(String? value) {
    if (value == null || value.isNotEmpty == false) {
      return EMPTY_DOB;
    } else if (value.length < 10) {
      return INVALID_DOB;
    } else {
      try {
        var parts = value.split('/');
        final newDate = DateTime.parse("${parts[2]}${parts[1]}${parts[0]}");
        if (newDate.isBefore(DateTime(1940, 1, 1)) ||
            newDate.isAfter(DateTime(2016, 12, 30))) {
          return INVALID_DOB;
        }

        String formatted = DateFormat('dd-MM-yyyy').format(newDate);

        var partsFormatted = formatted.split('-');

        if (partsFormatted[0] != parts[0] ||
            partsFormatted[1] != parts[1] ||
            partsFormatted[2] != parts[2]) {
          return INVALID_DOB;
        }
        return "";
      } catch (e) {
        return INVALID_DOB;
      }
    }
  }

  bool isEmptyOrNull(String? text) {
    if (text == null) return true;

    return text.isEmpty;
  }

  String validateExercise(String exerciseLevelString) {
    if (isEmptyOrNull(exerciseLevelString)) {
      return EMPTY_EXERCISE;
    }

    return "";
  }

  String validateEmail(String email) {
    if (email.isEmpty) {
      return EMPTY_EMAIL;
    }
    return '';
  }

  String validatePassword(String password) {
    if (password.isEmpty) {
      return EMPTY_PASSWORD;
    }
    return '';
  }

  String validateConfirmPassword(String password, String passwordConfirmation) {
    if (passwordConfirmation.isEmpty) {
      return EMPTY_PASSWORD_CONFIRMATION;
    }
    if (password != passwordConfirmation) {
      return PASSWORDS_DONT_MATCH;
    }
    return '';
  }
}

class DateCustomValidator implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length < 3) {
      return newValue;
    }

    String newValueModified =
        "${newValue.text[0]}${newValue.text[1]}/${newValue.text[2]}";

    if (newValue.text.length > 3) {
      newValueModified = newValueModified + newValue.text[3];
    }
    if (newValue.text.length > 4) {
      newValueModified = newValueModified + "/${newValue.text[4]}";
    }
    if (newValue.text.length > 5) {
      newValueModified = newValueModified + newValue.text[5];
    }
    if (newValue.text.length > 6) {
      newValueModified = newValueModified + newValue.text[6];
    }
    if (newValue.text.length > 7) {
      newValueModified = newValueModified + newValue.text[7];
    }

    return TextEditingValue(
        text: newValueModified,
        selection: TextSelection.collapsed(offset: newValueModified.length));
  }
}
