import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';

class FirestoreUtils {
  static final FirestoreUtils _instance = FirestoreUtils._internal();

  // Private constructor for singleton
  FirestoreUtils._internal();

  // Public factory method to return the same instance
  factory FirestoreUtils() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get a collection reference
  CollectionReference getCollection(String collectionPath) {
    LoggerService.logInfo('Accessing collection: $collectionPath');
    return _firestore.collection(collectionPath);
  }

  // Add a document to a collection
  Future<DocumentReference?> addDocument(
      String collectionPath, Map<String, dynamic> data) async {
    try {
      LoggerService.logInfo('Adding document to collection: $collectionPath');
      final docRef = await getCollection(collectionPath).add(data);
      LoggerService.logInfo(
          'Document added with ID: ${docRef.id} in collection: $collectionPath');
      return docRef;
    } catch (e) {
      LoggerService.logError(
          'Failed to add document in collection: $collectionPath - Error: $e');
      SnackbarUtils.showErrorSnackBar(message: 'Failed to add document');
      return null;
    }
  }

  // Update a document by ID
  Future<void> updateDocument(
      String collectionPath, String docId, Map<String, dynamic> data) async {
    try {
      LoggerService.logInfo(
          'Updating document ID: $docId in collection: $collectionPath');
      await getCollection(collectionPath).doc(docId).update(data);
      LoggerService.logInfo(
          'Document updated with ID: $docId in collection: $collectionPath');
    } catch (e) {
      LoggerService.logError(
          'Failed to update document ID: $docId in collection: $collectionPath - Error: $e');
      SnackbarUtils.showErrorSnackBar(message: 'Failed to update document');
    }
  }

  // Delete a document by ID
  Future<void> deleteDocument(String collectionPath, String docId) async {
    try {
      LoggerService.logInfo(
          'Deleting document ID: $docId in collection: $collectionPath');
      await getCollection(collectionPath).doc(docId).delete();
      LoggerService.logInfo(
          'Document deleted with ID: $docId in collection: $collectionPath');
    } catch (e) {
      LoggerService.logError(
          'Failed to delete document ID: $docId in collection: $collectionPath - Error: $e');
      SnackbarUtils.showErrorSnackBar(message: 'Failed to delete document');
    }
  }

  // Fetch a document by ID
  Future<DocumentSnapshot?> getDocument(
      String collectionPath, String docId) async {
    try {
      LoggerService.logInfo(
          'Fetching document ID: $docId from collection: $collectionPath');
      final docSnapshot = await getCollection(collectionPath).doc(docId).get();
      LoggerService.logInfo(
          'Document fetched with ID: $docId from collection: $collectionPath');
      return docSnapshot;
    } catch (e) {
      LoggerService.logError(
          'Failed to fetch document ID: $docId from collection: $collectionPath - Error: $e');
      SnackbarUtils.showErrorSnackBar(message: 'Failed to fetch document');
      return null;
    }
  }

  Future<DocumentSnapshot?> getDocumentCollectionDoc(String collectionPath,
      String docId, String nextCollection, String nextDoc) async {
    try {
      LoggerService.logInfo(
          'Fetching document ID: $docId from collection: $collectionPath , Next Collection: $nextCollection Next Doc $nextDoc ');
      final docSnapshot = await _firestore
          .collection(collectionPath)
          .doc(docId)
          .collection(nextCollection)
          .doc(nextDoc)
          .get();
      LoggerService.logInfo(
          'Document fetched with ID: $docId from collection: $collectionPath , Next Collection: $nextCollection Next Doc $nextDoc ');
      return docSnapshot;
    } catch (e) {
      LoggerService.logError(
          'Failed to fetch document ID: $docId from collection: $collectionPath - Error: $e');
      SnackbarUtils.showErrorSnackBar(message: 'Failed to fetch document');
      return null;
    }
  }

  // Fetch all documents in a collection
  Future<List<DocumentSnapshot>> getAllDocuments(String collectionPath) async {
    try {
      LoggerService.logInfo(
          'Fetching all documents from collection: $collectionPath');
      final querySnapshot = await getCollection(collectionPath).get();
      LoggerService.logInfo(
          'Fetched ${querySnapshot.docs.length} documents from collection: $collectionPath');
      return querySnapshot.docs;
    } catch (e) {
      LoggerService.logError(
          'Failed to fetch documents from collection: $collectionPath - Error: $e');
      SnackbarUtils.showErrorSnackBar(message: 'Failed to fetch documents');
      return [];
    }
  }

  // Stream real-time updates for a collection
  Stream<QuerySnapshot> streamCollection(String collectionPath) {
    LoggerService.logInfo('Streaming collection: $collectionPath');
    return getCollection(collectionPath).snapshots();
  }

  // Stream real-time updates for a specific document
  Stream<DocumentSnapshot> streamDocument(String collectionPath, String docId) {
    LoggerService.logInfo(
        'Streaming document ID: $docId from collection: $collectionPath');
    return getCollection(collectionPath).doc(docId).snapshots();
  }

  // Paginated query for a collection
  Future<List<DocumentSnapshot>> getPaginatedDocuments(
    String collectionPath, {
    DocumentSnapshot? lastDocument,
    int limit = 10,
  }) async {
    try {
      LoggerService.logInfo(
          'Fetching paginated documents from collection: $collectionPath');
      Query query = getCollection(collectionPath).limit(limit);

      if (lastDocument != null) {
        LoggerService.logInfo(
            'Starting after document ID: ${lastDocument.id} for collection: $collectionPath');
        query = query.startAfterDocument(lastDocument);
      }

      final querySnapshot = await query.get();
      LoggerService.logInfo(
          'Fetched ${querySnapshot.docs.length} documents with pagination from collection: $collectionPath');
      return querySnapshot.docs;
    } catch (e) {
      LoggerService.logError(
          'Failed to fetch paginated documents from collection: $collectionPath - Error: $e');
      SnackbarUtils.showErrorSnackBar(
          message: 'Failed to fetch paginated documents');
      return [];
    }
  }
}
